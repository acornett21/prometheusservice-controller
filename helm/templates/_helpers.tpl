{{/* The name of the application this chart installs */}}
{{- define "ack-prometheusservice-controller.app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ack-prometheusservice-controller.app.fullname" -}}
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

{{/* The name and version as used by the chart label */}}
{{- define "ack-prometheusservice-controller.chart.name-version" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* The name of the service account to use */}}
{{- define "ack-prometheusservice-controller.service-account.name" -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}

{{- define "ack-prometheusservice-controller.watch-namespace" -}}
{{- if eq .Values.installScope "namespace" -}}
{{ .Values.watchNamespace | default .Release.Namespace }}
{{- end -}}
{{- end -}}

{{/* The mount path for the shared credentials file */}}
{{- define "ack-prometheusservice-controller.aws.credentials.secret_mount_path" -}}
{{- "/var/run/secrets/aws" -}}
{{- end -}}

{{/* The path the shared credentials file is mounted */}}
{{- define "ack-prometheusservice-controller.aws.credentials.path" -}}
{{- printf "%s/%s" (include "aws.credentials.secret_mount_path" .) .Values.aws.credentials.secretKey -}}
{{- end -}}

{{/* The rules a of ClusterRole or Role */}}
{{- define "ack-prometheusservice-controller.rbac-rules" -}}
rules:
- apiGroups:
  - ""
  resources:
  - configmaps
  verbs:
  - get
  - list
  - patch
  - watch
- apiGroups:
  - ""
  resources:
  - namespaces
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - secrets
  verbs:
  - get
  - list
  - patch
  - watch
- apiGroups:
  - prometheusservice.services.k8s.aws
  resources:
  - alertmanagerdefinitions
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - prometheusservice.services.k8s.aws
  resources:
  - alertmanagerdefinitions/status
  verbs:
  - get
  - patch
  - update
- apiGroups:
  - prometheusservice.services.k8s.aws
  resources:
  - loggingconfigurations
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - prometheusservice.services.k8s.aws
  resources:
  - loggingconfigurations/status
  verbs:
  - get
  - patch
  - update
- apiGroups:
  - prometheusservice.services.k8s.aws
  resources:
  - rulegroupsnamespaces
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - prometheusservice.services.k8s.aws
  resources:
  - rulegroupsnamespaces/status
  verbs:
  - get
  - patch
  - update
- apiGroups:
  - prometheusservice.services.k8s.aws
  resources:
  - workspaces
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - prometheusservice.services.k8s.aws
  resources:
  - workspaces/status
  verbs:
  - get
  - patch
  - update
- apiGroups:
  - services.k8s.aws
  resources:
  - adoptedresources
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - services.k8s.aws
  resources:
  - adoptedresources/status
  verbs:
  - get
  - patch
  - update
- apiGroups:
  - services.k8s.aws
  resources:
  - fieldexports
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - services.k8s.aws
  resources:
  - fieldexports/status
  verbs:
  - get
  - patch
  - update
{{- end }}