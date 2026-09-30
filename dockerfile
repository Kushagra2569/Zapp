FROM golang:1.27 AS build-stage

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY . ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /zapp

# Deploy the application binary into a lean image to drastically reduce the size of image
FROM gcr.io/distroless/base-debian12 AS build-release-stage

WORKDIR /

COPY --from=build-stage /zapp /zapp

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/zapp"]
