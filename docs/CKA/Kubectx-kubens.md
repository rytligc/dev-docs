# Kubectx & Kubens CLI's

## Kubectx

```bash
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
```

### Syntax for Kubectx

```bash
# List all contexts
kubectx

# Switch to a new context
kubectx <context>

# Switch back to previous context
kubectx -

# Get current context
kubectx -c
```

## Kubens

```bash
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
```

### Syntax for Kubens

```bash
# List namespaces
kubens

# Switch to different namespace
kubens <namespace>

# Switch back to previous namespace
kubens -
```
