package metadata

// These sources produce JSON providing a structured representation of the
// Vector CLI (commands, flags, etc.)
_default_flags: {
	"help": {
		_short:      "h"
		description: "Prints help information"
	}
	"version": {
		_short:      "V"
		description: "Prints version information"
	}
}

cli: {
	#Args: [Arg=string]: {
		description: !=""
		name:        Arg
		type:        #ArgType
		default?:    string | [...string]
	}

	#ArgType: "string" | "list"

	#Commands: [Command=string]: {
		description: !=""
		name:        Command
		flags?:      #Flags
		options?:    #Options
		args?:       #Args
	}

	#Flags: [Flag=string]: {
		flag:        "--\(Flag)"
		description: string
		env_var?:    string
		name:        Flag

		if _short != _|_ {
			short: "-\(_short)"
		}

		_short: string
	}

	#Options: [Option=string]: {
		option:      "--\(Option)"
		default?:    string | int
		description: string
		enum?:       #Enum
		name:        Option
		type:        #OptionType
		env_var?:    string
		example?:    string
		required:    bool | *false

		if default == _|_ {
			required: true
		}

		if _short != _|_ {
			short: "-\(_short)"
		}

		_short: !=""

		if enum != _|_ {
			type: "enum"
		}
	}

	#OptionType: "string" | "integer" | "enum"

	name:     !=""
	flags:    #Flags
	options:  #Options
	commands: #Commands
}

cli: {
	name: "vector"

	flags: _default_flags & {
		"quiet": {
			_short: "q"
			description: """
				Reduce detail of internal logging. Repeat to reduce further. Overrides
				`--verbose`
				"""
		}
		"require-healthy": {
			_short:      "r"
			description: "Exit on startup if any sinks fail healthchecks"
			env_var:     "VECTOR_REQUIRE_HEALTHY"
		}
		"verbose": {
			_short:      "v"
			description: "Enable more detailed logging. Repeat to reduce further. Overrides `--verbose`"
		}
		"watch-config": {
			_short:      "w"
			description: "Watch for changes in the configuration file, and reload accordingly"
			env_var:     "VECTOR_WATCH_CONFIG"
		}
	}

	options: {
		"color": {
			description: "Control when ANSI terminal formatting is used."
			default:     "auto"
			enum: {
				always: "Enable ANSI terminal formatting always."
				auto:   "Detect ANSI terminal formatting and enable if supported."
				never:  "Disable ANSI terminal formatting."
			}
		}
		"config": {
			_short: "c"
			description: """
				Read configuration from one or more files. Wildcard paths are
				supported. If zero files are specified the default config path
				`/etc/vector/vector.toml` will be targeted
				"""
			type:    "string"
			default: "/etc/vector/vector.toml"
			env_var: "VECTOR_CONFIG"
		}
		"threads": {
			_short: "t"
			description: """
				Number of threads to use for processing (default is number of
				available cores)
				"""
			type:    "integer"
			env_var: "VECTOR_THREADS"
		}
		"log-format": {
			description: "Set the logging format [default: text]"
			default:     "text"
			enum: {
				json: "Output Vector's logs as JSON."
				text: "Output Vector's logs as text."
			}
		}
	}

	commands: {
		"generate": {
			description: "Generate a Vector configuration containing a list of components"

			flags: _default_flags & {
				"fragment": {
					_short:      "f"
					description: "Whether to skip the generation of global fields"
				}
			}

			options: {
				"file": {
					description: "Generate config as a file"
					type:        "string"
					example:     "/etc/vector/my-config.toml"
				}
			}

			args: {
				pipeline: {
					description: "Pipeline expression, e.g. `stdin/json_parser,add_fields/console`"
					type:        "string"
				}
			}
		}

		"help": {
			description: "Prints this message or the help of the given subcommand(s)"
		}

		"list": {
			description: "List available components, then exit"

			flags: _default_flags

			options: {
				"format": {
					description: "Format the list in an encoding schema"
					default:     "text"
					enum: {
						json: "Output components as JSON"
						text: "Output components as text"
					}
				}
			}
		}

		"test": {
			description: """
				Run Vector config unit tests, then exit. This command is experimental and
				therefore subject to change. For guidance on how to write unit tests check
				out: https://vector.dev/docs/setup/guides/unit-testing/
				"""

			args: {
				paths: _paths_arg & {
					description: """
						Any number of Vector config files to test. If none are specified
						the default config path `/etc/vector/vector.toml` will be targeted
						"""
				}
			}
		}

		"top": {
			description: """
				Display topology and metrics in the console, for a local or remote Vector
				instance
				"""

			flags: _default_flags & {
				"human-metrics": {
					_short: "h"
					description: """
						Humanize metrics, using numeric suffixes - e.g. 1,100 = 1.10 k,
						1,000,000 = 1.00 M
						"""
				}
			}

			options: {
				"refresh-interval": {
					_short:      "i"
					description: "How often the screen refreshes (in milliseconds)"
					type:        "integer"
					default:     500
				}
				"url": {
					_short:      "u"
					description: "The URL for the GraphQL endpoint of the running Vector instance"
					type:        "string"
				}
			}
		}

		"validate": {
			description: "Validate the target config, then exit"

			flags: _default_flags & {
				"no-environment": {
					_short: "ne"
					description: """
						Disables environment checks. That includes component
						checks and health checks
						"""
				}
				"deny-warnings": {
					_short:      "d"
					description: "Fail validation on warnings"
				}
			}

			args: {
				paths: _paths_arg & {
					description: """
						Any number of Vector config files to validate. If none are specified
						the default config path `/etc/vector/vector.toml` will be targeted
						"""
				}
			}
		}
	}

	// Helpers
	_paths_arg: {
		type:    "list"
		default: "/etc/vector/vector.toml"
	}
}
