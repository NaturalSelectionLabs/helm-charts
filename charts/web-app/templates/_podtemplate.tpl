{{- define "web-app.podTemplate" }}
    metadata:
      annotations:
        {{- include "web-app.annotations" . |  nindent 8 }}
      {{- with .Values.podAnnotations }}
        {{- toYaml . | nindent 8 }}
      {{- end }}
      labels:
        {{- include "web-app.selectorLabels" . | nindent 8 }}
    spec:
      {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      serviceAccountName: {{ include "web-app.serviceAccountName" . }}
      securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 8 }}
      {{- with .Values.workload.initContainers }}
      initContainers:
      {{- toYaml . | nindent 8 }}
      {{- end }}
      containers:
        - name: {{ .Values.workload.name | default .Chart.Name }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - name: http
              containerPort: {{ .Values.service.port }}
              protocol: TCP
          {{- if.Values.livenessProbe }}
          livenessProbe:
            {{- toYaml .Values.livenessProbe | nindent 12 }}
          {{- end }}
          {{- if .Values.readinessProbe}}
          readinessProbe:
            {{- toYaml .Values.readinessProbe | nindent 12 }}
          {{- end }}
          {{- if .Values.env -}}
          env:
            {{- range $key, $value := .Values.env }}
            - name: {{ $key }}
              value: {{ printf "'%s'" $value }}
            {{- end }}
          {{- end }}
          envFrom:
            {{- toYaml .Values.envFrom | nindent 12 }}
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
          {{- if .Values.workload.command }}
          command:
          {{- range .Values.workload.command }}
            - {{ . | quote }}
          {{- end }}
          {{- end }}
          {{- if .Values.workload.args }}
          args:
          {{- range .Values.workload.args }}
            - {{ . | quote }}
          {{- end }}
          {{- end }}
      {{- with .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.affinity }}
      affinity:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.tolerations }}
      tolerations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
{{- end -}}