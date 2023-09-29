{{/*
Create the createsecret name.
*/}}
{{- define "tsa.createsecret.name" -}}
{{- include "common.names.managedname" (dict "content" $.Values.createsecret "context" $) }}
{{- end -}}

{{/*
Create a fully qualified createsecret name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "tsa.createsecret.fullname" -}}
{{- include "common.names.managedfullname" (dict "content" $.Values.createsecret "context" $) }}
{{- end -}}


{{/*
Create the name of the service account to use for the createsecret component
*/}}
{{- define "tsa.serviceAccountName.createsecret" -}}
{{- include "common.names.serviceAccountName" (dict "content" $.Values.createsecret "context" $) }}
{{- end -}}

{{/*
Create the cert-chain name
*/}}
{{- define "tsa.cert-chain.name" -}}
{{ include "common.names.fullnameSuffix" (dict "suffix" "cert-chain" "context" $) }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "tsa.serviceAccountName" -}}
{{- include "common.names.serviceAccountName" (dict "content" $.Values.server "context" $) }}
{{- end }}

{{/*
Create the tsa secret name
*/}}
{{- define "tsa.secret.name" -}}
{{ tpl (.Values.secret | default (include "tsa.cert-chain.name" .)) $ }}
{{- end }}

{{/*
Server Arguments
*/}}
{{- define "tsa.server.args" -}}
- "serve"
- "--host=0.0.0.0"
- "--port={{ .Values.server.portHTTP }}"
- "--timestamp-signer={{ .Values.server.secret.signer }}"
{{- if eq .Values.server.secret.signer "tink" }}
- "--tink-key-resource={{ required "Tink key for signing timestamp responses is required" .Values.server.secret.tink_key_resource }}"
- "--tink-keyset-path={{ .Values.server.secretMount }}/tink.keyset.enc"
- "--certificate-chain-path={{ .Values.server.secretMount }}/cert-chain"
- "--tink-hcvault-token={{ required "Tink authentication token for Hashicorp Vault API is required" .Values.server.secret.tink_hcvault_token }}"
{{- end }}
{{- if eq .Values.server.secret.signer "kms" }}
- "--kms-key-resource={{ required "KMS key for signing timestamp responses is required" .Values.server.secret.kms_key_resource }}"
- "--certificate-chain-path={{ .Values.server.secretMount }}/cert-chain"
{{- end }}
{{- if eq .Values.server.secret.signer "file" }}
- "--file-signer-key-path={{ .Values.server.secretMount }}/signing-secret"
- "--file-signer-passwd=$(SIGNING_SECRET_PASSWORD)"
- "--certificate-chain-path={{ .Values.server.secretMount }}/cert-chain"
{{- end }}
{{- if .Values.server.logging.production }}
- "--log-type=prod"
{{- end -}}
{{- if .Values.server.extraArgs -}}
{{- range $key, $value := .Values.server.extraArgs }}
{{- if $value }}
- {{ printf "%v=%v" $key $value | quote }}
{{- else }}
- {{ printf $key | quote }}
{{- end }}
{{- end }}
{{- end -}}
{{- end -}}


{{/*
Create the image path for the passed in image field
*/}}
{{- define "tsa.image" -}}
{{- if eq (substr 0 7 .version) "sha256:" -}}
{{- printf "%s/%s@%s" .registry .repository .version -}}
{{- else -}}
{{- printf "%s/%s:%s" .registry .repository .version -}}
{{- end -}}
{{- end -}}

{{/*
Create Container Ports based on Service Ports
*/}}
{{- define "tsa.containerPorts" -}}
{{- range . }}
- containerPort: {{ (ternary .port .targetPort (empty .targetPort)) | int }}
  protocol: {{ default "TCP" .protocol }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the config
*/}}
{{- define "tsa.config" -}}
{{ printf "%s-config" (include "tsa.fullname" .) }}
{{- end }}

{{/*
Return the appropriate apiVersion for ingress.
*/}}
{{- define "tsa.server.ingress.backend" -}}
{{- $root := index . 0 -}}
{{- $local := index . 1 -}}
{{- $servicePort := index . 2 -}}
service:
  name: {{ (default (include "tsa.fullname" $root) $local.service_name) }}
  port:
    number: {{ $servicePort | int }}
{{- end -}}
