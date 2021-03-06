package metadata

components: sources: internal_metrics: {
	title:       "Internal Metrics"
	description: "The internal metrics source exposes metrics emitted by the running Vector instance (as opposed to components in its topology)."

	classes: {
		commonly_used: true
		delivery:      "at_least_once"
		deployment_roles: ["aggregator", "daemon", "sidecar"]
		development:   "beta"
		egress_method: "batch"
	}

	features: {
		collect: {
			checkpoint: enabled: false
			from: service: {
				name:     "Vector instance"
				thing:    "a \(name)"
				url:      urls.vector_docs
				versions: ">= 0.11.0"
			}
		}
		multiline: enabled: false
	}

	support: {
		platforms: {
			"aarch64-unknown-linux-gnu":  true
			"aarch64-unknown-linux-musl": true
			"x86_64-apple-darwin":        true
			"x86_64-pc-windows-msv":      true
			"x86_64-unknown-linux-gnu":   true
			"x86_64-unknown-linux-musl":  true
		}

		notices: []
		requirements: []
		warnings: []
	}

	output: metrics: {
		// Default internal metrics tags
		_internal_metrics_tags: {
			instance: {
				description: "The Vector instance identified by host and port."
				required:    true
				examples: [_values.instance]
			}
			job: {
				description: "The name of the job producing Vector metrics."
				required:    true
				default:     "vector"
			}
		}

		// Instance-level "process" metrics
		api_started_total: {
			description:       "The number of times the Vector GraphQL API has been started."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		config_load_errors_total: {
			description:       "The total number of errors loading the Vector configuration."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		connection_errors_total: {
			description:       "The total number of connection errors for this Vector instance."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		quit_total: {
			description:       "The total number of times the Vector instance has quit."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		recover_errors_total: {
			description:       "The total number of errors caused by Vector failing to recover from a failed reload."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		reload_errors_total: {
			description:       "The total number of errors encountered when reloading Vector."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		reloaded_total: {
			description:       "The total number of times the Vector instance has been reloaded."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		started_total: {
			description:       "The total number of times the Vector instance has been started."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		stopped_total: {
			description:       "The total number of times the Vector instance has been stopped."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}

		// Metrics emitted by one or more components
		// Reusable metric definitions
		adaptive_concurrency_averaged_rtt: {
			description:       "The average round-trip time (RTT) from the HTTP sink across the current window."
			type:              "histogram"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		adaptive_concurrency_in_flight: {
			description:       "The number of outbound requests from the HTTP sink currently awaiting a response."
			type:              "histogram"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		adaptive_concurrency_limit: {
			description:       "The concurrency limit that the adaptive concurrency feature has decided on for this current window."
			type:              "histogram"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		adaptive_concurrency_observed_rtt: {
			description:       "The observed round-trip time (RTT) for requests from this HTTP sink."
			type:              "histogram"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		checkpoint_write_errors_total: {
			description:       "The total number of errors writing checkpoints."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		checkpoints_total: {
			description:       "The total number of files checkpointed."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		checksum_errors: {
			description:       "The total number of errors identifying files via checksum."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags & {
				file: _file
			}
		}
		collect_completed_total: {
			description:       "The total number of MongoDB metrics collections completed."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		collect_duration_nanoseconds: {
			description:       "The duration spent collecting MongoDB metrics."
			type:              "histogram"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		communication_errors_total: {
			description:       "The total number of errors stemming from communication with the Docker daemon."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		connection_read_errors_total: {
			description:       "The total number of errors reading datagram."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags & {
				mode: {
					description: ""
					required:    true
					options: {
						udp: "User Datagram Protocol"
					}
				}
			}
		}
		consumer_offset_updates_failed_total: {
			description:       "The total number of failures to update a Kafka consumer offset."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		container_processed_events_total: {
			description:       "The total number of container events processed."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		container_metadata_fetch_errors_total: {
			description:       "The total number of errors encountered when fetching container metadata."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		containers_unwatched_total: {
			description:       "The total number of times Vector stopped watching for container logs."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		containers_watched_total: {
			description:       "The total number of times Vector started watching for container logs."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		docker_format_parse_failures_total: {
			description:       "The total number of failures to parse a message as a JSON object."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		event_annotation_failures_total: {
			description:       "The total number of failures to annotate Vector events with Kubernetes Pod metadata."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		events_discarded_total: {
			description:       "The total number of events discarded by this component."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		events_failed_total: {
			description:       "The total number of failures to read a Kafka message."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		processed_events_total: {
			description:       "The total number of events processed by this component."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags & {
				file: _file
			}
		}
		file_delete_errors: {
			description:       "The total number of failures to delete a file."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags & {
				file: _file
			}
		}
		file_watch_errors: {
			description:       "The total number of errors encountered when watching files."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags & {
				file: _file
			}
		}
		files_added: {
			description:       "The total number of files Vector has found to watch."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags & {
				file: _file
			}
		}
		files_deleted: {
			description:       "The total number of files deleted."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags & {
				file: _file
			}
		}
		files_resumed: {
			description:       "The total number of times Vector has resumed watching a file."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags & {
				file: _file
			}
		}
		files_unwatched: {
			description:       "The total number of times Vector has stopped watching a file."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags & {
				file: _file
			}
		}
		fingerprint_read_errors: {
			description:       "The total number of times Vector failed to read a file for fingerprinting."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags & {
				file: _file
			}
		}
		http_bad_requests_total: {
			description:       "The total number of HTTP `400 Bad Request` errors encountered."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		http_error_response_total: {
			description:       "The total number of HTTP error responses for this component."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		http_request_errors_total: {
			description:       "The total number of HTTP request errors for this component."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		http_requests_total: {
			description:       "The total number of HTTP requests issued by this component."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		invalid_record_total: {
			description:       "The total number of invalid records that have been discarded."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		invalid_record_bytes_total: {
			description:       "The total number of bytes from invalid records that have been discarded."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		logging_driver_errors_total: {
			description: """
				The total number of logging driver errors encountered caused by not using either
				the `jsonfile` or `journald` driver.
				"""
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		memory_used: {
			description:       "The total memory currently being used by Vector (in bytes)."
			type:              "gauge"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		metadata_refresh_failed_total: {
			description:       "The total number of failed efforts to refresh AWS EC2 metadata."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		metadata_refresh_successful_total: {
			description:       "The total number of AWS EC2 metadata refreshes."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		missing_keys_total: {
			description:       "The total number of events dropped due to keys missing from the event."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		open_connections: {
			description:       "The number of current open connections to Vector."
			type:              "gauge"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		parse_errors_total: {
			description:       "The total number of errors parsing Prometheus metrics."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		processed_bytes_total: {
			description:       "The total number of bytes processed by the component."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		processing_errors_total: {
			description:       "The total number of processing errors encountered by this component."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags & {
				error_type: _error_type
			}
		}
		protobuf_decode_errors_total: {
			description:       "The total number of [Protocol Buffers](\(urls.protobuf)) errors thrown during communication between Vector instances."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		request_duration_nanoseconds: {
			description:       "The request duration for this component (in nanoseconds)."
			type:              "histogram"
			default_namespace: "vector"
			tags:              _component_tags
		}
		request_error_total: {
			description:       "The total number of MongoDB request errors."
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		request_read_errors_total: {
			description:       "The total number of request read errors for this component."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		requests_completed_total: {
			description:       "The total number of requests completed by this component."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		requests_received_total: {
			description:       "The total number of requests received by this component."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		sqs_message_delete_failed_total: {
			description:       "The total number of failures to delete SQS messages."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		sqs_message_delete_succeeded_total: {
			description:       "The total number of successful deletions of SQS messages."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		sqs_message_processing_failed_total: {
			description:       "The total number of failures to process SQS messages."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		sqs_message_processing_succeeded_total: {
			description:       "The total number of SQS messages successfully processed."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}

		sqs_message_receive_failed_total: {
			description:       "The total number of failures to receive SQS messages."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		sqs_message_receive_succeeded_total: {
			description:       "The total number of times successfully receiving SQS messages."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		sqs_message_received_messages_total: {
			description:       "The total number of received SQS messages."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		sqs_s3_event_record_ignored_total: {
			description:       "The total number of times an S3 record in an SQS message was ignored (for an event that was not `ObjectCreated`)."
			type:              "counter"
			default_namespace: "vector"

			tags: _component_tags & {
				ignore_type: {
					description: "The reason for ignoring the S3 record"
					required:    true
					options: [
						"invalid_event_kind",
					]
				}
			}
		}
		stale_events_flushed_total: {
			description:       "The number of stale events that Vector has flushed."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		stdin_reads_failed_total: {
			description:       "The total number of errors reading from stdin."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		tag_value_limit_exceeded_total: {
			description: """
				The total number of events discarded because the tag has been rejected after
				hitting the configured `value_limit`.
				"""
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		timestamp_parse_errors_total: {
			description:       "The total number of errors encountered parsing [RFC3339](\(urls.rfc_3339)) timestamps."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}
		uptime_seconds: {
			description:       "The total number of seconds the Vector instance has been up."
			type:              "gauge"
			default_namespace: "vector"
			tags:              _component_tags
		}
		utf8_convert_errors_total: {
			description:       "The total number of errors converting bytes to a UTF-8 string in UDP mode."
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags & {
				mode: {
					description: "The connection mode used by the component."
					required:    true
					options: {
						udp: "User Datagram Protocol"
					}
				}
			}
		}
		value_limit_reached_total: {
			description: """
				The total number of times new values for a key have been rejected because the
				value limit has been reached.
				"""
			type:              "counter"
			default_namespace: "vector"
			tags:              _component_tags
		}

		// Windows metrics
		windows_service_does_not_exist_total: {
			description: """
				The total number of errors raised due to the Windows service not
				existing.
				"""
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		windows_service_install_total: {
			description: """
				The total number of times the Windows service has been installed.
				"""
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		windows_service_restart_total: {
			description: """
				The total number of times the Windows service has been restarted.
				"""
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		windows_service_start_total: {
			description: """
				The total number of times the Windows service has been started.
				"""
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		windows_service_stop_total: {
			description: """
				The total number of times the Windows service has been stopped.
				"""
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}
		windows_service_uninstall_total: {
			description: """
				The total number of times the Windows service has been uninstalled.
				"""
			type:              "counter"
			default_namespace: "vector"
			tags:              _internal_metrics_tags
		}

		// Helpful tag groupings
		_component_tags: _internal_metrics_tags & {
			component_kind: _component_kind
			component_name: _component_name
			component_type: _component_type
		}

		_internal_metrics_tags: {
			instance: _instance
			job:      _job
		}

		// All available tags
		_collector: {
			description: "Which collector this metric comes from."
			required:    true
		}
		_component_kind: {
			description: "The component's kind (options are `source`, `sink`, or `transform`)."
			required:    true
			options: ["sink", "source", "transform"]
		}
		_component_name: {
			description: "The name of the component as specified in the Vector configuration."
			required:    true
			examples: ["file_source", "splunk_sink"]
		}
		_component_type: {
			description: "The type of component (source, transform, or sink)."
			required:    true
			examples: ["file", "http", "honeycomb", "splunk_hec"]
		}
		_endpoint: {
			description: "The absolute path of originating file."
			required:    true
			examples: ["http://localhost:8080/server-status?auto"]
		}
		_error_type: {
			description: "The type of the error"
			required:    true
			options: [
				"field_missing",
				"invalid_metric",
				"mapping_failed",
				"match_failed",
				"parse_failed",
				"render_error",
				"type_conversion_failed",
				"type_field_does_not_exist",
				"type_ip_address_parse_error",
				"value_invalid",
			]
		}
		_file: {
			description: "The file that produced the error"
			required:    false
		}
		_host: {
			description: "The hostname of the originating system."
			required:    true
			examples: [_values.local_host]
		}
		_instance: {
			description: "The Vector instance identified by host and port."
			required:    true
			examples: [_values.instance]
		}
		_job: {
			description: "The name of the job producing Vector metrics."
			required:    true
			default:     "vector"
		}
	}
}
