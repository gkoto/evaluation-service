package main

import (
	"net/http"

	"go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp"
)

func otelMiddleware(handler http.Handler) http.Handler {
	return otelhttp.NewHandler(handler, "http.request")
}
