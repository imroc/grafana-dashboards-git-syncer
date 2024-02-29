# grafana dashboards git syncer

A sidecar container to sync grafana dashboards from git repo.

## Usage

Accept the following environment variables:

* `DIR`: The directory where the git repository is cloned. Defaults to `/var/lib/grafana/git-sync-dashboards`.
* `PULL_INTERVAL`: The interval in seconds to pull the git repository. Defaults to `1h`.
* `WEBHOOK_URL`: The URL to send notification to grafana api, e.g `http://localhost:3000/api/admin/provisioning/dashboards/reload`. Defaults to `""`, which means notification is not enabled.
* `WEBHOOK_METHOD`: The HTTP method to send notification to grafana api if notification is enabled. Defaults to `POST`.
* `WEBHOOK_USERNAME` and `WEBHOOK_PASSWORD`: The username and password of grafana to send notification if notification is enabled.

You can use it as a sidecar of grafana pod in kubenretes:

```yaml
        - name: git-sync-dashboards
          image: docker.io/imroc/grafana-dashboards-git-syncer:v1.0.0
          imagePullPolicy: Always
          securityContext:
            runAsUser: 0
            runAsGroup: 0
            privileged: true
            runAsNonRoot: false
          env:
            - name: DIR
              value: /var/lib/grafana/git-sync-dashboards
            - name: WEBHOOK_URL
              value: http://localhost:3000/api/admin/provisioning/dashboards/reload
            - name: WEBHOOK_METHOD
              value: POST
            - name: WEBHOOK_USERNAME
              valueFrom:
                secretKeyRef:
                  key: admin-user
                  name: grafana
            - name: WEBHOOK_PASSWORD
              valueFrom:
                secretKeyRef:
                  key: admin-password
                  name: grafana
          volumeMounts:
            - mountPath: /var/lib/grafana/git-sync-dashboards
              name: dashboards
      volumes:
        - name: dashboards
          emptyDir: {}
```
