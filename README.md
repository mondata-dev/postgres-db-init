# postgres-db-init

Simple docker container that can be used to initialize a postgresql database for a kubernetes service.

## Example Usage

```yaml
  initContainers:
    - name: init-db
      image: mondata/postgres-db-init
      imagePullPolicy: Always
      envFrom:
        - configMapRef:
            name: db-configmap
      env:
        - name: PGADMINPASSWORD
          valueFrom:
            secretKeyRef:
              name: postgresql-secret
              key: postgresql-password
        - name: PGUSER
          value: newuser
        - name: PGPASSWORD
          value: newsecret
        - name: PGDATABASE
          value: yourdb
```

This assumes the following kubernetes resources:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: postgresql-secret
type: Opaque
stringData:
  postgresql-password: geheim
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: db-configmap
data:
  PGADMINUSER: postgres
  PGHOST:      example.com
  PGPORT:      5432
```

## Build & Deploy

```bash
docker build -t mondata/postgres-db-init:VERSION .
docker push mondata/postgres-db-init:VERSION
git tag -a VERSION
git push --follow-tags
```
