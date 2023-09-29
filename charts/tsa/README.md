# tsa

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.3](https://img.shields.io/badge/AppVersion-0.1.3-informational?style=flat-square)

Timestamp Authority issuing RFC3161 signed timestamps.

**Homepage:** <https://sigstore.dev/>

## Quick Installation

To install the helm chart with default values run following command.
The [Values](#Values) section describes the configuration options for this chart.

```shell
helm dependency update .
helm install [RELEASE_NAME] .
```

## Uninstallation

To uninstall the Helm chart run following command.

```shell
helm uninstall [RELEASE_NAME]
```

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| The Sigstore Authors |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://repo-securesign-helm-v2.apps.open-svc-sts.k1wl.p1.openshiftapps.com/helm-charts | common | 0.2.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| createsecret.annotations | object | `{}` |  |
| createsecret.containerSecurityContext.enabled | bool | `false` |  |
| createsecret.enabled | bool | `true` |  |
| createsecret.extraEnvVars | list | `[]` |  |
| createsecret.extraEnvVarsCM | string | `""` |  |
| createsecret.extraEnvVarsSecret | string | `""` |  |
| createsecret.extraVolumeMounts | list | `[]` |  |
| createsecret.extraVolumes | list | `[]` |  |
| createsecret.image.imagePullPolicy | string | `"IfNotPresent"` |  |
| createsecret.image.imagePullSecrets | list | `[]` |  |
| createsecret.image.registry | string | `"ghcr.io"` |  |
| createsecret.image.repository | string | `"sigstore/scaffolding/createcertchain"` |  |
| createsecret.image.version | string | `"sha256:50adb488a468fc0215e0b8e558e16fbab4026245d9a48fc0ee7275403f307b72"` |  |
| createsecret.name | string | `"createsecret"` |  |
| createsecret.nodeSelector | object | `{}` |  |
| createsecret.podSecurityContext.enabled | bool | `true` |  |
| createsecret.podSecurityContext.runAsNonRoot | bool | `true` |  |
| createsecret.podSecurityContext.runAsUser | int | `65533` |  |
| createsecret.serviceAccount.annotations | object | `{}` |  |
| createsecret.serviceAccount.create | bool | `true` |  |
| createsecret.serviceAccount.mountToken | bool | `true` |  |
| createsecret.serviceAccount.name | string | `""` |  |
| createsecret.tolerations | list | `[]` |  |
| createsecret.ttlSecondsAfterFinished | int | `3600` |  |
| forceNamespace | string | `""` |  |
| namespace.create | bool | `false` |  |
| namespace.name | string | `"tsa-system"` |  |
| server.annotations | object | `{}` |  |
| server.containerSecurityContext.enabled | bool | `false` |  |
| server.extraEnvVars | list | `[]` |  |
| server.extraEnvVarsCM | string | `""` |  |
| server.extraEnvVarsSecret | string | `""` |  |
| server.extraVolumeMounts | list | `[]` |  |
| server.extraVolumes | list | `[]` |  |
| server.image.imagePullPolicy | string | `"IfNotPresent"` |  |
| server.image.imagePullSecrets | list | `[]` |  |
| server.image.registry | string | `"ghcr.io"` |  |
| server.image.repository | string | `"sigstore/timestamp-server"` |  |
| server.image.version | string | `"sha256:b0be2fb18150bcbfe15ff82d95bd9373a5ac7e6d8c7663299940a78e43fe69aa"` | v1.1.1 |
| server.ingress | object | `{}` |  |
| server.ingresses | list | `[]` |  |
| server.logging.production | bool | `false` |  |
| server.name | string | `"server"` |  |
| server.nodeSelector | object | `{}` |  |
| server.podAnnotations | object | `{}` |  |
| server.podSecurityContext.enabled | bool | `true` |  |
| server.podSecurityContext.runAsNonRoot | bool | `true` |  |
| server.podSecurityContext.runAsUser | int | `65533` |  |
| server.portHTTP | int | `5555` |  |
| server.replicaCount | int | `1` |  |
| server.secret.cert_chain | string | `""` |  |
| server.secret.kms_key_resource | string | `""` |  |
| server.secret.name | string | `""` |  |
| server.secret.signer | string | `"file"` |  |
| server.secret.signing_secret | string | `""` |  |
| server.secret.signing_secret_password | string | `""` |  |
| server.secret.tink_enc_keyset | string | `""` |  |
| server.secret.tink_hcvault_token | string | `""` |  |
| server.secret.tink_key_resource | string | `""` |  |
| server.secretMount | string | `"/var/run/tsa-secrets"` |  |
| server.service.ports[0].name | string | `"http"` |  |
| server.service.ports[0].port | int | `80` |  |
| server.service.ports[0].protocol | string | `"TCP"` |  |
| server.service.ports[0].targetPort | int | `5555` |  |
| server.service.ports[1].name | string | `"metrics"` |  |
| server.service.ports[1].port | int | `2112` |  |
| server.service.ports[1].protocol | string | `"TCP"` |  |
| server.service.ports[1].targetPort | int | `2112` |  |
| server.service.type | string | `"ClusterIP"` |  |
| server.serviceAccount.annotations | object | `{}` |  |
| server.serviceAccount.create | bool | `true` |  |
| server.serviceAccount.mountToken | bool | `true` |  |
| server.serviceAccount.name | string | `""` |  |
| server.svcPort | int | `80` |  |
| server.tolerations | list | `[]` |  |

----------------------------------------------

## Ingress

To enabled access from external resources, an Ingress resource is created. The configuration necessary for each Ingress resource is primarily dependent on the specific Ingress Controller being used. In most cases, implementation specific configuration is specified as annotations on the Ingress resources. These can be applied using the `server.ingress.annotations` parameter.

>
> ```shell
> server:
>   ingresses:
>     - enabled: true
>       hosts:
>         - host: timestamp.localhost
>           path: /
> ```
