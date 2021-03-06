---
last_modified_on: "2020-11-26"
$schema: ".schema.json"
title: "0.11 Upgrade Guide"
description: "An upgrade guide that addresses breaking changes"
author_github: "https://github.com/binarylogic"
pr_numbers: [3557, 4580, 4557, 4647, 4918, 3297, 3427, 4103]
release: "0.11.0"
hide_on_release_notes: false
tags: ["type: breaking change"]
---

0.11 includes some minor breaking changes:

1. [The metrics emitted by the `internal_metrics` source have changed names.](#first)
2. [The `statsd` sink now supports all socket types.](#second)
3. [The `reduce` tranform `identifier_fields` was renamed to `group_by`.](#third)
4. [The `source_type` field is now explicit in the `splunk_hec` sink.](#fourth)
5. [Remove forwarding to syslog from distributed systemd unit.](#fifth)
6. [The `http` source no longer dedots JSON fields.](#sixth)

We cover each below to help you upgrade quickly:

## Upgrade Guide

### The metrics emitted by the `internal_metrics` source have changed names<a name="first"></a>

We have not officially announced the `internal_metrics` source (coming in 0.12)
due to the high probability of breaking changes. Specifically, the metric names
and labels. Since then we've settled on a [metric naming convention][metric_naming_convention]
that is largely inspired by the [Prometheus naming convention][prometheus_naming_convention].
0.11 includes these naming changes.

To upgrade, please see the following:

1. [`internal_metrics` names][internal_metrics_output]
2. [Metric names diff][metric_names_diff]

You'll likely need to update any downstream consumers of this data. We plan to
ship official Vector dashboards in 0.12 that will relieve this maintenance
burden for you in the future.

### The `statsd` sink now supports all socket types<a name="second"></a>

If you're using the [`statsd` sink][statsd_sink] you'll need to add the new
`mode` option that specifies which protocol you'd like to use. Previously, the
only protocol available was UDP.

```diff title="vector.toml"
 [sinks.statsd]
   type = "statsd"
+  mode = "udp"
```

### The `reduce` tranform `identifier_fields` was renamed to `group_by`<a name="third"></a>

We renamed the `reduce` transform's `identifier_fields` option to `group_by`
for clarity. We are repositioning this transform to handle broad reduce
operations, such as merging multi-line logs together:

```diff title="vector.toml"
 [sinks.reduce]
   type = "reduce"
-  identifier_fields = ["my_field"]
+  group_by = ["my_field"]
```

### The `source_type` field is now explicit in the `splunk_hec` sink<a name="fourth"></a>

Previously, the `splunk_hec` sink was using the event's `source_type` field
and mapping that to Splunk's expected `sourcetype` field. Splunk uses this
field to inform parsing and processing of the data. Because this field can
vary depending on your data, we've made the `sourcetype` field an explicit
option:

```diff title="vector.toml"
 [sinks.reduce]
   type = "splunk_hec"
+  sourcetype = "syslog" # only set this if your `message` field is formatted as syslog
```

Only set this field if you want to explicitly inform Splunk of your `message`
field's format. Most users will not want to set this field.

### Remove forwarding to syslog from distributed systemd unit<a name="fifth"></a>

Vector's previous Systemd unit file included configuration that forwarded
Vector's logs over Syslog. This was presumptuous and we've removed these
settings in favor of your system defaults.

If you'd like Vector to continue logging to Syslog, you'll need to add back
the [removed options][removed_systemd_syslog_options], but most users should
not have to do anything.

### The `http` source no longer dedots JSON fields<a name="sixth"></a>

Previously, the `http` source would dedot JSON keys in incoming data. This means
that a JSON payload like this:

```json
{
  "first.second": "value"
}
```

Would turn into this after being ingested into Vector:

```json
{
  "first": {
    "second": "value"
  }
}
```

This is incorrect as Vector should not alter your data in this way. This has
been corrected and your events will keep `.` in their key names.

There is nothing you need to do to upgrade except understand that your data
structure may change if it contained `.` characters in the keys.

[internal_metrics_output]: /docs/reference/sources/internal_metrics/#metric-events
[metric_names_diff]: https://github.com/timberio/vector/pull/4647/files
[metric_naming_convention]: https://github.com/timberio/vector/blob/master/CONTRIBUTING.md#metric-naming-convention
[prometheus_naming_convention]: https://prometheus.io/docs/practices/naming/
[removed_systemd_syslog_options]: https://github.com/timberio/vector/pull/3427/files
