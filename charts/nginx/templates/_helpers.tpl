{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{ define "nginx_image" -}}
{{ .Values.images.nginx.name }}:{{ or .Values.global.imageTag .Values.images.nginx.tag }}
{{- end }}

{{ define "default_backend_image" -}}
{{ .Values.images.defaultBackend.name }}:{{ or .Values.global.imageTag .Values.images.defaultBackend.tag }}
{{- end }}

{{ define "ingress_class" -}}
{{- if .Values.ingressClass -}}
{{- .Values.ingressClass -}}
{{- else }}
{{- template "fullname" . -}}
{{- end -}}
{{- end -}}
