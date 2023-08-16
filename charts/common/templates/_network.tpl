{{/*
Create Container Ports based on Service Ports
*/}}
{{- define "common.network.containerPorts" -}}
{{- range . }}
- containerPort: {{ (ternary .port .targetPort (empty .targetPort)) | int }}
  protocol: {{ default "TCP" .protocol }}
{{- end -}}
{{- end -}}

{{/*
Return the Ingress backend.
Usage:
{{ include "common.network.ingress.backend" (dict "global" $ "context" . "port" $.Values.port) }}
*/}}
{{- define "common.network.ingress.backend" -}}
service:
  name: {{ (default (include "common.names.fullname" .global) .context.name) }}
  port:
    number: {{ .port | int }}
{{- end -}}
