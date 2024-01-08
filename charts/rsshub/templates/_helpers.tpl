{{/*
Expand the name of the chart.
*/}}
{{- define "rsshub.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rsshub.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rsshub.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "rsshub.labels" -}}
helm.sh/chart: {{ include "rsshub.chart" . }}
{{ include "rsshub.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rsshub.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rsshub.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "rsshub.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "rsshub.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create redis name and version as used by the chart label.
*/}}
{{- define "rsshub.redis.fullname" -}}
{{- $redisHa := (index .Values "redis-ha") -}}
{{- $redisHaContext := dict "Chart" (dict "Name" "redis-ha") "Release" .Release "Values" $redisHa -}}
{{- if $redisHa.enabled -}}
    {{- if $redisHa.haproxy.enabled -}}
        {{- printf "%s-haproxy" (include "redis-ha.fullname" $redisHaContext) | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
{{- else -}}
{{- printf "%s-%s" (include "rsshub.fullname" .) .Values.redis.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the redis service account to use
*/}}
{{- define "rsshub.redisServiceAccountName" -}}
{{- if .Values.redis.serviceAccount.create -}}
    {{ default (include "rsshub.redis.fullname" .) .Values.redis.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.redis.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "rsshub.redis.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rsshub.name" . }}-{{ .Values.redis.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create puppeteer name and version as used by the chart label.
*/}}
{{- define "rsshub.puppeteer.fullname" -}}
{{- $puppeteerHa := (index .Values "puppeteer-ha") -}}
{{- $puppeteerHaContext := dict "Chart" (dict "Name" "puppeteer-ha") "Release" .Release "Values" $puppeteerHa -}}
{{- if $puppeteerHa.enabled -}}
    {{- if $puppeteerHa.haproxy.enabled -}}
        {{- printf "%s-haproxy" (include "puppeteer-ha.fullname" $puppeteerHaContext) | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
{{- else -}}
{{- printf "%s-%s" (include "rsshub.fullname" .) .Values.puppeteer.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the puppeteer service account to use
*/}}
{{- define "rsshub.puppeteerServiceAccountName" -}}
{{- if .Values.puppeteer.serviceAccount.create -}}
    {{ default (include "rsshub.puppeteer.fullname" .) .Values.puppeteer.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.puppeteer.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "rsshub.puppeteer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rsshub.name" . }}-{{ .Values.puppeteer.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rsshub.puppeteer.labels" -}}
helm.sh/chart: {{ include "rsshub.chart" . }}
{{ include "rsshub.puppeteer.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.puppeteer.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}