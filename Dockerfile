FROM golang:1.19-alpine

LABEL com.github.actions.color="green"
LABEL com.github.actions.description="Scan your code with GoKart to finds vulnerabilities using the SSA (single static assignment) form of Go source code."
LABEL com.github.actions.icon="check"
LABEL com.github.actions.name="GoKart Scanner"
LABEL description="Integrate GoKart security static analysis to GitHub Actions"
LABEL maintainer="dwisiswant0"
LABEL repository="https://github.com/selesy/gokart-action"

ARG version="v0.2.0"
ENV CGO_ENABLED=0
RUN go install github.com/selesy/gokart-pre@v0.5.2-rc1
RUN apk add --no-cache bash findutils
COPY entrypoint.sh /bin/entrypoint
RUN chmod +x /bin/entrypoint

ENTRYPOINT ["/bin/entrypoint"]
