{{/*
Create the name of the service account to use
*/}}
{{- define "tuf.serviceAccountName" -}}
{{- include "common.names.serviceAccountName" (dict "content" $.Values.server "context" $) }}
{{- end }}
{{/*
Server Arguments
*/}}
{{- define "tuf.server.args" -}}
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
Define the raw tuf.namespace template if set with forceNamespace or .Release.Namespace is set
*/}}
{{- define "tuf.rawnamespace" -}}
{{- if .Values.forceNamespace -}}
{{ print .Values.forceNamespace }}
{{- else -}}
{{ print .Release.Namespace }}
{{- end -}}
{{- end -}}
{{/*
Define the tuf.namespace template if set with forceNamespace or .Release.Namespace is set
*/}}
{{- define "tuf.namespace" -}}
{{ printf "namespace: %s" (include "tuf.rawnamespace" .) }}
{{- end -}}