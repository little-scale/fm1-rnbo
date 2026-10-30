{
  "patcher": {
    "fileversion": 1,
    "appversion": {
      "major": 9,
      "minor": 0,
      "revision": 9,
      "architecture": "arm64",
      "modernui": 1
    },
    "rect": [
      100,
      100,
      640,
      360
    ],
    "boxes": [
      {
        "box": {
          "id": "obj-1",
          "maxclass": "newobj",
          "text": "midiin",
          "patching_rect": [
            40,
            40,
            160,
            22
          ],
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ]
        }
      },
      {
        "box": {
          "id": "obj-2",
          "maxclass": "newobj",
          "text": "rnbo~ @dumpoutlet 1",
          "patching_rect": [
            40,
            110,
            160,
            22
          ],
          "patcher": {
            "fileversion": 1,
            "classnamespace": "rnbo",
            "rect": [
              0,
              0,
              1180,
              900
            ],
            "boxes": [
              {
                "box": {
                  "id": "obj-1",
                  "text": "Clock Steps And Glide — Hold one key for an eight-step staircase. Release stops the clock; another key resumes the step position. Glide should smooth the jumps.",
                  "patching_rect": [
                    25,
                    30,
                    250,
                    22
                  ],
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": []
                }
              },
              {
                "box": {
                  "id": "obj-2",
                  "text": "param level 0.12 @min 0 @max 0.25 @displayorder 1 @displayname \"Level\"",
                  "patching_rect": [
                    305,
                    30,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "param_obj-2",
                  "rnbo_serial": 1,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "value": {
                        "attrOrProp": 2,
                        "digest": "Set initial value",
                        "defaultarg": 2,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Initial Value",
                        "displayorder": 3
                      },
                      "normalizedvalue": {
                        "attrOrProp": 1,
                        "digest": "Set value normalized. ",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset param to initial value",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "normalized": {
                        "attrOrProp": 1,
                        "digest": "Normalized parameter value.",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "name": {
                        "attrOrProp": 2,
                        "digest": "Name of the parameter",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "Parameter Name",
                        "mandatory": true
                      },
                      "enum": {
                        "attrOrProp": 2,
                        "digest": "Use an enumerated output",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "list",
                        "label": "Enum Values",
                        "displayorder": 6
                      },
                      "minimum": {
                        "attrOrProp": 2,
                        "digest": "Minimum value",
                        "isalias": false,
                        "aliases": [
                          "min"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Minimum",
                        "displayorder": 1
                      },
                      "min": {
                        "attrOrProp": 2,
                        "digest": "Minimum value",
                        "isalias": true,
                        "aliasOf": "minimum",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Minimum",
                        "displayorder": 1
                      },
                      "maximum": {
                        "attrOrProp": 2,
                        "digest": "Maximum value",
                        "isalias": false,
                        "aliases": [
                          "max"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Maximum",
                        "displayorder": 2
                      },
                      "max": {
                        "attrOrProp": 2,
                        "digest": "Maximum value",
                        "isalias": true,
                        "aliasOf": "maximum",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Maximum",
                        "displayorder": 2
                      },
                      "exponent": {
                        "attrOrProp": 2,
                        "digest": "Scale values exponentially",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Exponent",
                        "displayorder": 7
                      },
                      "steps": {
                        "attrOrProp": 2,
                        "digest": "Divide the output into a number of discrete steps",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Steps",
                        "displayorder": 8
                      },
                      "displayName": {
                        "attrOrProp": 2,
                        "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": true,
                        "touched": false,
                        "type": "symbol",
                        "label": "Display Name"
                      },
                      "displayname": {
                        "attrOrProp": 2,
                        "digest": "A more readable name for the parameter in an external RNBO target",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Display Name",
                        "displayorder": 14
                      },
                      "unit": {
                        "attrOrProp": 2,
                        "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Unit",
                        "displayorder": 15
                      },
                      "tonormalized": {
                        "attrOrProp": 2,
                        "digest": "Converts a real parameter value to its normalized form",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "To Normalized Expression",
                        "displayorder": 10
                      },
                      "fromnormalized": {
                        "attrOrProp": 2,
                        "digest": "Converts a normalized parameter into its actual parameter value",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "From Normalized Expression",
                        "displayorder": 9
                      },
                      "order": {
                        "attrOrProp": 2,
                        "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "0",
                        "label": "Restore Order",
                        "displayorder": 12
                      },
                      "displayorder": {
                        "attrOrProp": 2,
                        "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "-",
                        "label": "Display Order",
                        "displayorder": 13
                      },
                      "sendinit": {
                        "attrOrProp": 2,
                        "digest": "Send initial value",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true",
                        "label": "Send Init",
                        "displayorder": 4
                      },
                      "ctlin": {
                        "attrOrProp": 2,
                        "digest": "MIDI controller number to control this parameter.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "-1",
                        "label": "MIDI Controller Number.",
                        "displayorder": 16
                      },
                      "meta": {
                        "attrOrProp": 2,
                        "digest": "A JSON formatted string containing metadata for use by the exported code",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Metadata",
                        "displayorder": 17
                      },
                      "nopreset": {
                        "attrOrProp": 2,
                        "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": true,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "preset": {
                        "attrOrProp": 2,
                        "digest": "Add this value to the preset.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true",
                        "label": "Include In Preset",
                        "displayorder": 11
                      }
                    },
                    "inputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Parameter value",
                        "defaultarg": 2,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "normalizedvalue",
                        "type": "number",
                        "digest": "Set value normalized. ",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Parameter value",
                        "defaultarg": 2,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "normalized",
                        "type": "number",
                        "digest": "Normalized parameter value.",
                        "docked": false
                      }
                    ],
                    "helpname": "param",
                    "aliasOf": "param",
                    "classname": "param",
                    "operator": false,
                    "versionId": -1093178486,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "param",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "name": "level",
                    "value": 0.12,
                    "min": 0,
                    "max": 0.25,
                    "displayorder": 1,
                    "displayname": "Level"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-3",
                  "text": "param period 180 @min 60 @max 700 @displayorder 2 @displayname \"Period\"",
                  "patching_rect": [
                    585,
                    30,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "param_obj-3",
                  "rnbo_serial": 2,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "value": {
                        "attrOrProp": 2,
                        "digest": "Set initial value",
                        "defaultarg": 2,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Initial Value",
                        "displayorder": 3
                      },
                      "normalizedvalue": {
                        "attrOrProp": 1,
                        "digest": "Set value normalized. ",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset param to initial value",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "normalized": {
                        "attrOrProp": 1,
                        "digest": "Normalized parameter value.",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "name": {
                        "attrOrProp": 2,
                        "digest": "Name of the parameter",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "Parameter Name",
                        "mandatory": true
                      },
                      "enum": {
                        "attrOrProp": 2,
                        "digest": "Use an enumerated output",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "list",
                        "label": "Enum Values",
                        "displayorder": 6
                      },
                      "minimum": {
                        "attrOrProp": 2,
                        "digest": "Minimum value",
                        "isalias": false,
                        "aliases": [
                          "min"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Minimum",
                        "displayorder": 1
                      },
                      "min": {
                        "attrOrProp": 2,
                        "digest": "Minimum value",
                        "isalias": true,
                        "aliasOf": "minimum",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Minimum",
                        "displayorder": 1
                      },
                      "maximum": {
                        "attrOrProp": 2,
                        "digest": "Maximum value",
                        "isalias": false,
                        "aliases": [
                          "max"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Maximum",
                        "displayorder": 2
                      },
                      "max": {
                        "attrOrProp": 2,
                        "digest": "Maximum value",
                        "isalias": true,
                        "aliasOf": "maximum",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Maximum",
                        "displayorder": 2
                      },
                      "exponent": {
                        "attrOrProp": 2,
                        "digest": "Scale values exponentially",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Exponent",
                        "displayorder": 7
                      },
                      "steps": {
                        "attrOrProp": 2,
                        "digest": "Divide the output into a number of discrete steps",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Steps",
                        "displayorder": 8
                      },
                      "displayName": {
                        "attrOrProp": 2,
                        "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": true,
                        "touched": false,
                        "type": "symbol",
                        "label": "Display Name"
                      },
                      "displayname": {
                        "attrOrProp": 2,
                        "digest": "A more readable name for the parameter in an external RNBO target",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Display Name",
                        "displayorder": 14
                      },
                      "unit": {
                        "attrOrProp": 2,
                        "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Unit",
                        "displayorder": 15
                      },
                      "tonormalized": {
                        "attrOrProp": 2,
                        "digest": "Converts a real parameter value to its normalized form",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "To Normalized Expression",
                        "displayorder": 10
                      },
                      "fromnormalized": {
                        "attrOrProp": 2,
                        "digest": "Converts a normalized parameter into its actual parameter value",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "From Normalized Expression",
                        "displayorder": 9
                      },
                      "order": {
                        "attrOrProp": 2,
                        "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "0",
                        "label": "Restore Order",
                        "displayorder": 12
                      },
                      "displayorder": {
                        "attrOrProp": 2,
                        "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "-",
                        "label": "Display Order",
                        "displayorder": 13
                      },
                      "sendinit": {
                        "attrOrProp": 2,
                        "digest": "Send initial value",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true",
                        "label": "Send Init",
                        "displayorder": 4
                      },
                      "ctlin": {
                        "attrOrProp": 2,
                        "digest": "MIDI controller number to control this parameter.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "-1",
                        "label": "MIDI Controller Number.",
                        "displayorder": 16
                      },
                      "meta": {
                        "attrOrProp": 2,
                        "digest": "A JSON formatted string containing metadata for use by the exported code",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Metadata",
                        "displayorder": 17
                      },
                      "nopreset": {
                        "attrOrProp": 2,
                        "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": true,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "preset": {
                        "attrOrProp": 2,
                        "digest": "Add this value to the preset.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true",
                        "label": "Include In Preset",
                        "displayorder": 11
                      }
                    },
                    "inputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Parameter value",
                        "defaultarg": 2,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "normalizedvalue",
                        "type": "number",
                        "digest": "Set value normalized. ",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Parameter value",
                        "defaultarg": 2,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "normalized",
                        "type": "number",
                        "digest": "Normalized parameter value.",
                        "docked": false
                      }
                    ],
                    "helpname": "param",
                    "aliasOf": "param",
                    "classname": "param",
                    "operator": false,
                    "versionId": -1093178486,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "param",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "name": "period",
                    "value": 180,
                    "min": 60,
                    "max": 700,
                    "displayorder": 2,
                    "displayname": "Period"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-4",
                  "text": "param interval 2 @min 0 @max 12 @displayorder 3 @displayname \"Interval\"",
                  "patching_rect": [
                    865,
                    30,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "param_obj-4",
                  "rnbo_serial": 3,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "value": {
                        "attrOrProp": 2,
                        "digest": "Set initial value",
                        "defaultarg": 2,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Initial Value",
                        "displayorder": 3
                      },
                      "normalizedvalue": {
                        "attrOrProp": 1,
                        "digest": "Set value normalized. ",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset param to initial value",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "normalized": {
                        "attrOrProp": 1,
                        "digest": "Normalized parameter value.",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "name": {
                        "attrOrProp": 2,
                        "digest": "Name of the parameter",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "Parameter Name",
                        "mandatory": true
                      },
                      "enum": {
                        "attrOrProp": 2,
                        "digest": "Use an enumerated output",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "list",
                        "label": "Enum Values",
                        "displayorder": 6
                      },
                      "minimum": {
                        "attrOrProp": 2,
                        "digest": "Minimum value",
                        "isalias": false,
                        "aliases": [
                          "min"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Minimum",
                        "displayorder": 1
                      },
                      "min": {
                        "attrOrProp": 2,
                        "digest": "Minimum value",
                        "isalias": true,
                        "aliasOf": "minimum",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Minimum",
                        "displayorder": 1
                      },
                      "maximum": {
                        "attrOrProp": 2,
                        "digest": "Maximum value",
                        "isalias": false,
                        "aliases": [
                          "max"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Maximum",
                        "displayorder": 2
                      },
                      "max": {
                        "attrOrProp": 2,
                        "digest": "Maximum value",
                        "isalias": true,
                        "aliasOf": "maximum",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Maximum",
                        "displayorder": 2
                      },
                      "exponent": {
                        "attrOrProp": 2,
                        "digest": "Scale values exponentially",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Exponent",
                        "displayorder": 7
                      },
                      "steps": {
                        "attrOrProp": 2,
                        "digest": "Divide the output into a number of discrete steps",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Steps",
                        "displayorder": 8
                      },
                      "displayName": {
                        "attrOrProp": 2,
                        "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": true,
                        "touched": false,
                        "type": "symbol",
                        "label": "Display Name"
                      },
                      "displayname": {
                        "attrOrProp": 2,
                        "digest": "A more readable name for the parameter in an external RNBO target",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Display Name",
                        "displayorder": 14
                      },
                      "unit": {
                        "attrOrProp": 2,
                        "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Unit",
                        "displayorder": 15
                      },
                      "tonormalized": {
                        "attrOrProp": 2,
                        "digest": "Converts a real parameter value to its normalized form",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "To Normalized Expression",
                        "displayorder": 10
                      },
                      "fromnormalized": {
                        "attrOrProp": 2,
                        "digest": "Converts a normalized parameter into its actual parameter value",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "From Normalized Expression",
                        "displayorder": 9
                      },
                      "order": {
                        "attrOrProp": 2,
                        "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "0",
                        "label": "Restore Order",
                        "displayorder": 12
                      },
                      "displayorder": {
                        "attrOrProp": 2,
                        "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "-",
                        "label": "Display Order",
                        "displayorder": 13
                      },
                      "sendinit": {
                        "attrOrProp": 2,
                        "digest": "Send initial value",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true",
                        "label": "Send Init",
                        "displayorder": 4
                      },
                      "ctlin": {
                        "attrOrProp": 2,
                        "digest": "MIDI controller number to control this parameter.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "-1",
                        "label": "MIDI Controller Number.",
                        "displayorder": 16
                      },
                      "meta": {
                        "attrOrProp": 2,
                        "digest": "A JSON formatted string containing metadata for use by the exported code",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Metadata",
                        "displayorder": 17
                      },
                      "nopreset": {
                        "attrOrProp": 2,
                        "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": true,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "preset": {
                        "attrOrProp": 2,
                        "digest": "Add this value to the preset.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true",
                        "label": "Include In Preset",
                        "displayorder": 11
                      }
                    },
                    "inputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Parameter value",
                        "defaultarg": 2,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "normalizedvalue",
                        "type": "number",
                        "digest": "Set value normalized. ",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Parameter value",
                        "defaultarg": 2,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "normalized",
                        "type": "number",
                        "digest": "Normalized parameter value.",
                        "docked": false
                      }
                    ],
                    "helpname": "param",
                    "aliasOf": "param",
                    "classname": "param",
                    "operator": false,
                    "versionId": -1093178486,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "param",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "name": "interval",
                    "value": 2,
                    "min": 0,
                    "max": 12,
                    "displayorder": 3,
                    "displayname": "Interval"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-5",
                  "text": "param glide 25 @min 0 @max 120 @displayorder 4 @displayname \"Glide\"",
                  "patching_rect": [
                    25,
                    96,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "param_obj-5",
                  "rnbo_serial": 4,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "value": {
                        "attrOrProp": 2,
                        "digest": "Set initial value",
                        "defaultarg": 2,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Initial Value",
                        "displayorder": 3
                      },
                      "normalizedvalue": {
                        "attrOrProp": 1,
                        "digest": "Set value normalized. ",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset param to initial value",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "normalized": {
                        "attrOrProp": 1,
                        "digest": "Normalized parameter value.",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "name": {
                        "attrOrProp": 2,
                        "digest": "Name of the parameter",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "Parameter Name",
                        "mandatory": true
                      },
                      "enum": {
                        "attrOrProp": 2,
                        "digest": "Use an enumerated output",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "list",
                        "label": "Enum Values",
                        "displayorder": 6
                      },
                      "minimum": {
                        "attrOrProp": 2,
                        "digest": "Minimum value",
                        "isalias": false,
                        "aliases": [
                          "min"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Minimum",
                        "displayorder": 1
                      },
                      "min": {
                        "attrOrProp": 2,
                        "digest": "Minimum value",
                        "isalias": true,
                        "aliasOf": "minimum",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Minimum",
                        "displayorder": 1
                      },
                      "maximum": {
                        "attrOrProp": 2,
                        "digest": "Maximum value",
                        "isalias": false,
                        "aliases": [
                          "max"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Maximum",
                        "displayorder": 2
                      },
                      "max": {
                        "attrOrProp": 2,
                        "digest": "Maximum value",
                        "isalias": true,
                        "aliasOf": "maximum",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Maximum",
                        "displayorder": 2
                      },
                      "exponent": {
                        "attrOrProp": 2,
                        "digest": "Scale values exponentially",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Exponent",
                        "displayorder": 7
                      },
                      "steps": {
                        "attrOrProp": 2,
                        "digest": "Divide the output into a number of discrete steps",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Steps",
                        "displayorder": 8
                      },
                      "displayName": {
                        "attrOrProp": 2,
                        "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": true,
                        "touched": false,
                        "type": "symbol",
                        "label": "Display Name"
                      },
                      "displayname": {
                        "attrOrProp": 2,
                        "digest": "A more readable name for the parameter in an external RNBO target",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Display Name",
                        "displayorder": 14
                      },
                      "unit": {
                        "attrOrProp": 2,
                        "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Unit",
                        "displayorder": 15
                      },
                      "tonormalized": {
                        "attrOrProp": 2,
                        "digest": "Converts a real parameter value to its normalized form",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "To Normalized Expression",
                        "displayorder": 10
                      },
                      "fromnormalized": {
                        "attrOrProp": 2,
                        "digest": "Converts a normalized parameter into its actual parameter value",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "From Normalized Expression",
                        "displayorder": 9
                      },
                      "order": {
                        "attrOrProp": 2,
                        "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "0",
                        "label": "Restore Order",
                        "displayorder": 12
                      },
                      "displayorder": {
                        "attrOrProp": 2,
                        "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "-",
                        "label": "Display Order",
                        "displayorder": 13
                      },
                      "sendinit": {
                        "attrOrProp": 2,
                        "digest": "Send initial value",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true",
                        "label": "Send Init",
                        "displayorder": 4
                      },
                      "ctlin": {
                        "attrOrProp": 2,
                        "digest": "MIDI controller number to control this parameter.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "-1",
                        "label": "MIDI Controller Number.",
                        "displayorder": 16
                      },
                      "meta": {
                        "attrOrProp": 2,
                        "digest": "A JSON formatted string containing metadata for use by the exported code",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Metadata",
                        "displayorder": 17
                      },
                      "nopreset": {
                        "attrOrProp": 2,
                        "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": true,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "preset": {
                        "attrOrProp": 2,
                        "digest": "Add this value to the preset.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true",
                        "label": "Include In Preset",
                        "displayorder": 11
                      }
                    },
                    "inputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Parameter value",
                        "defaultarg": 2,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "normalizedvalue",
                        "type": "number",
                        "digest": "Set value normalized. ",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Parameter value",
                        "defaultarg": 2,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "normalized",
                        "type": "number",
                        "digest": "Normalized parameter value.",
                        "docked": false
                      }
                    ],
                    "helpname": "param",
                    "aliasOf": "param",
                    "classname": "param",
                    "operator": false,
                    "versionId": -1093178486,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "param",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "name": "glide",
                    "value": 25,
                    "min": 0,
                    "max": 120,
                    "displayorder": 4,
                    "displayname": "Glide"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-6",
                  "text": "param rotate 0 @min 0 @max 7 @displayorder 5 @displayname \"Rotate\"",
                  "patching_rect": [
                    305,
                    96,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "param_obj-6",
                  "rnbo_serial": 5,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "value": {
                        "attrOrProp": 2,
                        "digest": "Set initial value",
                        "defaultarg": 2,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Initial Value",
                        "displayorder": 3
                      },
                      "normalizedvalue": {
                        "attrOrProp": 1,
                        "digest": "Set value normalized. ",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset param to initial value",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "normalized": {
                        "attrOrProp": 1,
                        "digest": "Normalized parameter value.",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "name": {
                        "attrOrProp": 2,
                        "digest": "Name of the parameter",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "Parameter Name",
                        "mandatory": true
                      },
                      "enum": {
                        "attrOrProp": 2,
                        "digest": "Use an enumerated output",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "list",
                        "label": "Enum Values",
                        "displayorder": 6
                      },
                      "minimum": {
                        "attrOrProp": 2,
                        "digest": "Minimum value",
                        "isalias": false,
                        "aliases": [
                          "min"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Minimum",
                        "displayorder": 1
                      },
                      "min": {
                        "attrOrProp": 2,
                        "digest": "Minimum value",
                        "isalias": true,
                        "aliasOf": "minimum",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Minimum",
                        "displayorder": 1
                      },
                      "maximum": {
                        "attrOrProp": 2,
                        "digest": "Maximum value",
                        "isalias": false,
                        "aliases": [
                          "max"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Maximum",
                        "displayorder": 2
                      },
                      "max": {
                        "attrOrProp": 2,
                        "digest": "Maximum value",
                        "isalias": true,
                        "aliasOf": "maximum",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Maximum",
                        "displayorder": 2
                      },
                      "exponent": {
                        "attrOrProp": 2,
                        "digest": "Scale values exponentially",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Exponent",
                        "displayorder": 7
                      },
                      "steps": {
                        "attrOrProp": 2,
                        "digest": "Divide the output into a number of discrete steps",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Steps",
                        "displayorder": 8
                      },
                      "displayName": {
                        "attrOrProp": 2,
                        "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": true,
                        "touched": false,
                        "type": "symbol",
                        "label": "Display Name"
                      },
                      "displayname": {
                        "attrOrProp": 2,
                        "digest": "A more readable name for the parameter in an external RNBO target",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Display Name",
                        "displayorder": 14
                      },
                      "unit": {
                        "attrOrProp": 2,
                        "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Unit",
                        "displayorder": 15
                      },
                      "tonormalized": {
                        "attrOrProp": 2,
                        "digest": "Converts a real parameter value to its normalized form",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "To Normalized Expression",
                        "displayorder": 10
                      },
                      "fromnormalized": {
                        "attrOrProp": 2,
                        "digest": "Converts a normalized parameter into its actual parameter value",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "From Normalized Expression",
                        "displayorder": 9
                      },
                      "order": {
                        "attrOrProp": 2,
                        "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "0",
                        "label": "Restore Order",
                        "displayorder": 12
                      },
                      "displayorder": {
                        "attrOrProp": 2,
                        "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "-",
                        "label": "Display Order",
                        "displayorder": 13
                      },
                      "sendinit": {
                        "attrOrProp": 2,
                        "digest": "Send initial value",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true",
                        "label": "Send Init",
                        "displayorder": 4
                      },
                      "ctlin": {
                        "attrOrProp": 2,
                        "digest": "MIDI controller number to control this parameter.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "-1",
                        "label": "MIDI Controller Number.",
                        "displayorder": 16
                      },
                      "meta": {
                        "attrOrProp": 2,
                        "digest": "A JSON formatted string containing metadata for use by the exported code",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Metadata",
                        "displayorder": 17
                      },
                      "nopreset": {
                        "attrOrProp": 2,
                        "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": true,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "preset": {
                        "attrOrProp": 2,
                        "digest": "Add this value to the preset.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true",
                        "label": "Include In Preset",
                        "displayorder": 11
                      }
                    },
                    "inputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Parameter value",
                        "defaultarg": 2,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "normalizedvalue",
                        "type": "number",
                        "digest": "Set value normalized. ",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Parameter value",
                        "defaultarg": 2,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "normalized",
                        "type": "number",
                        "digest": "Normalized parameter value.",
                        "docked": false
                      }
                    ],
                    "helpname": "param",
                    "aliasOf": "param",
                    "classname": "param",
                    "operator": false,
                    "versionId": -1093178486,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "param",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "name": "rotate",
                    "value": 0,
                    "min": 0,
                    "max": 7,
                    "displayorder": 5,
                    "displayname": "Rotate"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-7",
                  "text": "param pan 0.5 @min 0 @max 1 @displayorder 6 @displayname \"Pan\"",
                  "patching_rect": [
                    585,
                    96,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "param_obj-7",
                  "rnbo_serial": 6,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "value": {
                        "attrOrProp": 2,
                        "digest": "Set initial value",
                        "defaultarg": 2,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Initial Value",
                        "displayorder": 3
                      },
                      "normalizedvalue": {
                        "attrOrProp": 1,
                        "digest": "Set value normalized. ",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset param to initial value",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "normalized": {
                        "attrOrProp": 1,
                        "digest": "Normalized parameter value.",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "name": {
                        "attrOrProp": 2,
                        "digest": "Name of the parameter",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "Parameter Name",
                        "mandatory": true
                      },
                      "enum": {
                        "attrOrProp": 2,
                        "digest": "Use an enumerated output",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "list",
                        "label": "Enum Values",
                        "displayorder": 6
                      },
                      "minimum": {
                        "attrOrProp": 2,
                        "digest": "Minimum value",
                        "isalias": false,
                        "aliases": [
                          "min"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Minimum",
                        "displayorder": 1
                      },
                      "min": {
                        "attrOrProp": 2,
                        "digest": "Minimum value",
                        "isalias": true,
                        "aliasOf": "minimum",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Minimum",
                        "displayorder": 1
                      },
                      "maximum": {
                        "attrOrProp": 2,
                        "digest": "Maximum value",
                        "isalias": false,
                        "aliases": [
                          "max"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Maximum",
                        "displayorder": 2
                      },
                      "max": {
                        "attrOrProp": 2,
                        "digest": "Maximum value",
                        "isalias": true,
                        "aliasOf": "maximum",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Maximum",
                        "displayorder": 2
                      },
                      "exponent": {
                        "attrOrProp": 2,
                        "digest": "Scale values exponentially",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Exponent",
                        "displayorder": 7
                      },
                      "steps": {
                        "attrOrProp": 2,
                        "digest": "Divide the output into a number of discrete steps",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Steps",
                        "displayorder": 8
                      },
                      "displayName": {
                        "attrOrProp": 2,
                        "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": true,
                        "touched": false,
                        "type": "symbol",
                        "label": "Display Name"
                      },
                      "displayname": {
                        "attrOrProp": 2,
                        "digest": "A more readable name for the parameter in an external RNBO target",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Display Name",
                        "displayorder": 14
                      },
                      "unit": {
                        "attrOrProp": 2,
                        "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Unit",
                        "displayorder": 15
                      },
                      "tonormalized": {
                        "attrOrProp": 2,
                        "digest": "Converts a real parameter value to its normalized form",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "To Normalized Expression",
                        "displayorder": 10
                      },
                      "fromnormalized": {
                        "attrOrProp": 2,
                        "digest": "Converts a normalized parameter into its actual parameter value",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "From Normalized Expression",
                        "displayorder": 9
                      },
                      "order": {
                        "attrOrProp": 2,
                        "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "0",
                        "label": "Restore Order",
                        "displayorder": 12
                      },
                      "displayorder": {
                        "attrOrProp": 2,
                        "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "-",
                        "label": "Display Order",
                        "displayorder": 13
                      },
                      "sendinit": {
                        "attrOrProp": 2,
                        "digest": "Send initial value",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true",
                        "label": "Send Init",
                        "displayorder": 4
                      },
                      "ctlin": {
                        "attrOrProp": 2,
                        "digest": "MIDI controller number to control this parameter.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "-1",
                        "label": "MIDI Controller Number.",
                        "displayorder": 16
                      },
                      "meta": {
                        "attrOrProp": 2,
                        "digest": "A JSON formatted string containing metadata for use by the exported code",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Metadata",
                        "displayorder": 17
                      },
                      "nopreset": {
                        "attrOrProp": 2,
                        "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": true,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "preset": {
                        "attrOrProp": 2,
                        "digest": "Add this value to the preset.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true",
                        "label": "Include In Preset",
                        "displayorder": 11
                      }
                    },
                    "inputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Parameter value",
                        "defaultarg": 2,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "normalizedvalue",
                        "type": "number",
                        "digest": "Set value normalized. ",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Parameter value",
                        "defaultarg": 2,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "normalized",
                        "type": "number",
                        "digest": "Normalized parameter value.",
                        "docked": false
                      }
                    ],
                    "helpname": "param",
                    "aliasOf": "param",
                    "classname": "param",
                    "operator": false,
                    "versionId": -1093178486,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "param",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "name": "pan",
                    "value": 0.5,
                    "min": 0,
                    "max": 1,
                    "displayorder": 6,
                    "displayname": "Pan"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-8",
                  "text": "param attack 8 @min 1 @max 250 @displayorder 7 @displayname \"Attack\"",
                  "patching_rect": [
                    865,
                    96,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "param_obj-8",
                  "rnbo_serial": 7,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "value": {
                        "attrOrProp": 2,
                        "digest": "Set initial value",
                        "defaultarg": 2,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Initial Value",
                        "displayorder": 3
                      },
                      "normalizedvalue": {
                        "attrOrProp": 1,
                        "digest": "Set value normalized. ",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset param to initial value",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "normalized": {
                        "attrOrProp": 1,
                        "digest": "Normalized parameter value.",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "name": {
                        "attrOrProp": 2,
                        "digest": "Name of the parameter",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "Parameter Name",
                        "mandatory": true
                      },
                      "enum": {
                        "attrOrProp": 2,
                        "digest": "Use an enumerated output",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "list",
                        "label": "Enum Values",
                        "displayorder": 6
                      },
                      "minimum": {
                        "attrOrProp": 2,
                        "digest": "Minimum value",
                        "isalias": false,
                        "aliases": [
                          "min"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Minimum",
                        "displayorder": 1
                      },
                      "min": {
                        "attrOrProp": 2,
                        "digest": "Minimum value",
                        "isalias": true,
                        "aliasOf": "minimum",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Minimum",
                        "displayorder": 1
                      },
                      "maximum": {
                        "attrOrProp": 2,
                        "digest": "Maximum value",
                        "isalias": false,
                        "aliases": [
                          "max"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Maximum",
                        "displayorder": 2
                      },
                      "max": {
                        "attrOrProp": 2,
                        "digest": "Maximum value",
                        "isalias": true,
                        "aliasOf": "maximum",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Maximum",
                        "displayorder": 2
                      },
                      "exponent": {
                        "attrOrProp": 2,
                        "digest": "Scale values exponentially",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Exponent",
                        "displayorder": 7
                      },
                      "steps": {
                        "attrOrProp": 2,
                        "digest": "Divide the output into a number of discrete steps",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Steps",
                        "displayorder": 8
                      },
                      "displayName": {
                        "attrOrProp": 2,
                        "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": true,
                        "touched": false,
                        "type": "symbol",
                        "label": "Display Name"
                      },
                      "displayname": {
                        "attrOrProp": 2,
                        "digest": "A more readable name for the parameter in an external RNBO target",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Display Name",
                        "displayorder": 14
                      },
                      "unit": {
                        "attrOrProp": 2,
                        "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Unit",
                        "displayorder": 15
                      },
                      "tonormalized": {
                        "attrOrProp": 2,
                        "digest": "Converts a real parameter value to its normalized form",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "To Normalized Expression",
                        "displayorder": 10
                      },
                      "fromnormalized": {
                        "attrOrProp": 2,
                        "digest": "Converts a normalized parameter into its actual parameter value",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "From Normalized Expression",
                        "displayorder": 9
                      },
                      "order": {
                        "attrOrProp": 2,
                        "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "0",
                        "label": "Restore Order",
                        "displayorder": 12
                      },
                      "displayorder": {
                        "attrOrProp": 2,
                        "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "-",
                        "label": "Display Order",
                        "displayorder": 13
                      },
                      "sendinit": {
                        "attrOrProp": 2,
                        "digest": "Send initial value",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true",
                        "label": "Send Init",
                        "displayorder": 4
                      },
                      "ctlin": {
                        "attrOrProp": 2,
                        "digest": "MIDI controller number to control this parameter.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "-1",
                        "label": "MIDI Controller Number.",
                        "displayorder": 16
                      },
                      "meta": {
                        "attrOrProp": 2,
                        "digest": "A JSON formatted string containing metadata for use by the exported code",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Metadata",
                        "displayorder": 17
                      },
                      "nopreset": {
                        "attrOrProp": 2,
                        "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": true,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "preset": {
                        "attrOrProp": 2,
                        "digest": "Add this value to the preset.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true",
                        "label": "Include In Preset",
                        "displayorder": 11
                      }
                    },
                    "inputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Parameter value",
                        "defaultarg": 2,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "normalizedvalue",
                        "type": "number",
                        "digest": "Set value normalized. ",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Parameter value",
                        "defaultarg": 2,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "normalized",
                        "type": "number",
                        "digest": "Normalized parameter value.",
                        "docked": false
                      }
                    ],
                    "helpname": "param",
                    "aliasOf": "param",
                    "classname": "param",
                    "operator": false,
                    "versionId": -1093178486,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "param",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "name": "attack",
                    "value": 8,
                    "min": 1,
                    "max": 250,
                    "displayorder": 7,
                    "displayname": "Attack"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-9",
                  "text": "param release 180 @min 10 @max 1500 @displayorder 8 @displayname \"Release\"",
                  "patching_rect": [
                    25,
                    162,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "param_obj-9",
                  "rnbo_serial": 8,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "value": {
                        "attrOrProp": 2,
                        "digest": "Set initial value",
                        "defaultarg": 2,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Initial Value",
                        "displayorder": 3
                      },
                      "normalizedvalue": {
                        "attrOrProp": 1,
                        "digest": "Set value normalized. ",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset param to initial value",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "normalized": {
                        "attrOrProp": 1,
                        "digest": "Normalized parameter value.",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "name": {
                        "attrOrProp": 2,
                        "digest": "Name of the parameter",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "Parameter Name",
                        "mandatory": true
                      },
                      "enum": {
                        "attrOrProp": 2,
                        "digest": "Use an enumerated output",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "list",
                        "label": "Enum Values",
                        "displayorder": 6
                      },
                      "minimum": {
                        "attrOrProp": 2,
                        "digest": "Minimum value",
                        "isalias": false,
                        "aliases": [
                          "min"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Minimum",
                        "displayorder": 1
                      },
                      "min": {
                        "attrOrProp": 2,
                        "digest": "Minimum value",
                        "isalias": true,
                        "aliasOf": "minimum",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Minimum",
                        "displayorder": 1
                      },
                      "maximum": {
                        "attrOrProp": 2,
                        "digest": "Maximum value",
                        "isalias": false,
                        "aliases": [
                          "max"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Maximum",
                        "displayorder": 2
                      },
                      "max": {
                        "attrOrProp": 2,
                        "digest": "Maximum value",
                        "isalias": true,
                        "aliasOf": "maximum",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Maximum",
                        "displayorder": 2
                      },
                      "exponent": {
                        "attrOrProp": 2,
                        "digest": "Scale values exponentially",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1",
                        "label": "Exponent",
                        "displayorder": 7
                      },
                      "steps": {
                        "attrOrProp": 2,
                        "digest": "Divide the output into a number of discrete steps",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0",
                        "label": "Steps",
                        "displayorder": 8
                      },
                      "displayName": {
                        "attrOrProp": 2,
                        "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": true,
                        "touched": false,
                        "type": "symbol",
                        "label": "Display Name"
                      },
                      "displayname": {
                        "attrOrProp": 2,
                        "digest": "A more readable name for the parameter in an external RNBO target",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Display Name",
                        "displayorder": 14
                      },
                      "unit": {
                        "attrOrProp": 2,
                        "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Unit",
                        "displayorder": 15
                      },
                      "tonormalized": {
                        "attrOrProp": 2,
                        "digest": "Converts a real parameter value to its normalized form",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "To Normalized Expression",
                        "displayorder": 10
                      },
                      "fromnormalized": {
                        "attrOrProp": 2,
                        "digest": "Converts a normalized parameter into its actual parameter value",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "From Normalized Expression",
                        "displayorder": 9
                      },
                      "order": {
                        "attrOrProp": 2,
                        "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "0",
                        "label": "Restore Order",
                        "displayorder": 12
                      },
                      "displayorder": {
                        "attrOrProp": 2,
                        "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "-",
                        "label": "Display Order",
                        "displayorder": 13
                      },
                      "sendinit": {
                        "attrOrProp": 2,
                        "digest": "Send initial value",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true",
                        "label": "Send Init",
                        "displayorder": 4
                      },
                      "ctlin": {
                        "attrOrProp": 2,
                        "digest": "MIDI controller number to control this parameter.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "-1",
                        "label": "MIDI Controller Number.",
                        "displayorder": 16
                      },
                      "meta": {
                        "attrOrProp": 2,
                        "digest": "A JSON formatted string containing metadata for use by the exported code",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Metadata",
                        "displayorder": 17
                      },
                      "nopreset": {
                        "attrOrProp": 2,
                        "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": true,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "preset": {
                        "attrOrProp": 2,
                        "digest": "Add this value to the preset.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true",
                        "label": "Include In Preset",
                        "displayorder": 11
                      }
                    },
                    "inputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Parameter value",
                        "defaultarg": 2,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "normalizedvalue",
                        "type": "number",
                        "digest": "Set value normalized. ",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Parameter value",
                        "defaultarg": 2,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "normalized",
                        "type": "number",
                        "digest": "Normalized parameter value.",
                        "docked": false
                      }
                    ],
                    "helpname": "param",
                    "aliasOf": "param",
                    "classname": "param",
                    "operator": false,
                    "versionId": -1093178486,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "param",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "name": "release",
                    "value": 180,
                    "min": 10,
                    "max": 1500,
                    "displayorder": 8,
                    "displayname": "Release"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-10",
                  "text": "notein",
                  "patching_rect": [
                    305,
                    162,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "notein_obj-10",
                  "rnbo_serial": 9,
                  "rnboinfo": {
                    "needsInstanceInfo": false,
                    "argnames": {
                      "notenumber": {
                        "attrOrProp": 1,
                        "digest": "note number (0-127)",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "velocity": {
                        "attrOrProp": 1,
                        "digest": "velocity (0-127)",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "releasevelocity": {
                        "attrOrProp": 1,
                        "digest": "release velocity (0-127)",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "outchannel": {
                        "attrOrProp": 1,
                        "digest": "MIDI channel (1-16)",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "input": {
                        "attrOrProp": 1,
                        "digest": "MIDI Input",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "channel": {
                        "attrOrProp": 1,
                        "digest": "MIDI channel (0 for all)",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      }
                    },
                    "inputs": [
                      {
                        "name": "input",
                        "type": "number",
                        "digest": "MIDI Input",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "channel",
                        "type": "number",
                        "digest": "MIDI channel (0 for all)",
                        "defaultarg": 1,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "notenumber",
                        "type": "number",
                        "digest": "note number (0-127)",
                        "docked": false
                      },
                      {
                        "name": "velocity",
                        "type": "number",
                        "digest": "velocity (0-127)",
                        "docked": false
                      },
                      {
                        "name": "releasevelocity",
                        "type": "number",
                        "digest": "release velocity (0-127)",
                        "docked": false
                      },
                      {
                        "name": "outchannel",
                        "type": "number",
                        "digest": "MIDI channel (1-16)",
                        "docked": false
                      }
                    ],
                    "helpname": "notein",
                    "aliasOf": "notein",
                    "classname": "notein",
                    "operator": false,
                    "versionId": 0,
                    "changesPatcherIO": true
                  },
                  "rnbo_classname": "notein",
                  "numinlets": 2,
                  "numoutlets": 4,
                  "outlettype": [
                    "",
                    "",
                    "",
                    ""
                  ],
                  "rnbo_extra_attributes": {}
                }
              },
              {
                "box": {
                  "id": "obj-11",
                  "text": "expr 440. * exp((in1 - 69.) * 0.0577622650466621)",
                  "patching_rect": [
                    585,
                    162,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr_obj-11",
                  "rnbo_serial": 10,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "doNotShowInMaxInspector": true
                      },
                      "hot": {
                        "attrOrProp": 2,
                        "digest": "Trigger computation on all inlets.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "number",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "number",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr",
                    "aliasOf": "expr",
                    "classname": "expr",
                    "operator": false,
                    "versionId": 835263063,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "expr": [
                      440,
                      "*",
                      "exp((in1",
                      "-",
                      "69.)",
                      "*",
                      "0.0577622650466621)"
                    ]
                  }
                }
              },
              {
                "box": {
                  "id": "obj-12",
                  "text": "/ 127.",
                  "patching_rect": [
                    865,
                    162,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr_obj-12",
                  "rnbo_serial": 11,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in2": {
                        "attrOrProp": 1,
                        "digest": "in2",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "127"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "doNotShowInMaxInspector": true
                      },
                      "hot": {
                        "attrOrProp": 2,
                        "digest": "Trigger computation on all inlets.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "number",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": "number",
                        "digest": "in2",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "number",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr",
                    "aliasOf": "expr",
                    "classname": "expr",
                    "operator": false,
                    "versionId": 835263063,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "in2": 127,
                    "serialclassname": "/",
                    "expr": "out1 = in2==0.?0.:in1/in2",
                    "isConvertedOperator": true,
                    "cold": true
                  }
                }
              },
              {
                "box": {
                  "id": "obj-13",
                  "text": "adsr~ 8 40 0.7 180",
                  "patching_rect": [
                    25,
                    228,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "adsr~_obj-13",
                  "rnbo_serial": 12,
                  "rnboinfo": {
                    "needsInstanceInfo": false,
                    "argnames": {
                      "attack": {
                        "attrOrProp": 1,
                        "digest": "Attack of the ADSR. The duration in ms of the attack portion of the envelope. This is the time it takes for the incoming signal to go from silence to full volume.",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "decay": {
                        "attrOrProp": 1,
                        "digest": "decay",
                        "defaultarg": 2,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "sustain": {
                        "attrOrProp": 1,
                        "digest": "sustain",
                        "defaultarg": 3,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "release": {
                        "attrOrProp": 1,
                        "digest": "release",
                        "defaultarg": 4,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "legato": {
                        "attrOrProp": 1,
                        "digest": "Start retriggered attack on current value.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "maxsustain": {
                        "attrOrProp": 1,
                        "digest": "Maximum sustain",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "-1"
                      },
                      "out": {
                        "attrOrProp": 1,
                        "digest": "out",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "signal"
                      },
                      "mute": {
                        "attrOrProp": 1,
                        "digest": "Bang after envelope finished.",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "bang"
                      }
                    },
                    "inputs": [
                      {
                        "name": "trigger",
                        "type": [
                          "number",
                          "signal"
                        ],
                        "digest": "Send a non-zero value to sample accurately trigger an ADSR curve.",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "attack",
                        "type": "auto",
                        "digest": "Attack of the ADSR. The duration in ms of the attack portion of the envelope. This is the time it takes for the incoming signal to go from silence to full volume.",
                        "defaultarg": 1,
                        "docked": false
                      },
                      {
                        "name": "decay",
                        "type": "auto",
                        "digest": "decay",
                        "defaultarg": 2,
                        "docked": false
                      },
                      {
                        "name": "sustain",
                        "type": "auto",
                        "digest": "sustain",
                        "defaultarg": 3,
                        "docked": false
                      },
                      {
                        "name": "release",
                        "type": "auto",
                        "digest": "release",
                        "defaultarg": 4,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out",
                        "type": "signal",
                        "digest": "out",
                        "docked": false
                      },
                      {
                        "name": "mute",
                        "type": "bang",
                        "digest": "Bang after envelope finished.",
                        "docked": false
                      }
                    ],
                    "helpname": "adsr~",
                    "aliasOf": "adsr~",
                    "classname": "adsr~",
                    "operator": false,
                    "versionId": 0,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "adsr~",
                  "numinlets": 5,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "attack": 8,
                    "decay": 40,
                    "sustain": 0.7,
                    "release": 180
                  }
                }
              },
              {
                "box": {
                  "id": "obj-14",
                  "text": "> 0",
                  "patching_rect": [
                    305,
                    228,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr_obj-14",
                  "rnbo_serial": 13,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in2": {
                        "attrOrProp": 1,
                        "digest": "in2",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "doNotShowInMaxInspector": true
                      },
                      "hot": {
                        "attrOrProp": 2,
                        "digest": "Trigger computation on all inlets.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "number",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": "number",
                        "digest": "in2",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "number",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr",
                    "aliasOf": "expr",
                    "classname": "expr",
                    "operator": false,
                    "versionId": 835263063,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "in2": 0,
                    "serialclassname": ">",
                    "expr": "out1 = in1>in2",
                    "isConvertedOperator": true,
                    "cold": true
                  }
                }
              },
              {
                "box": {
                  "id": "obj-15",
                  "text": "metro 180",
                  "patching_rect": [
                    585,
                    228,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "metro_obj-15",
                  "rnbo_serial": 14,
                  "rnboinfo": {
                    "needsInstanceInfo": false,
                    "argnames": {
                      "on": {
                        "attrOrProp": 1,
                        "digest": "Turn metronome off or on (0, 1).",
                        "isalias": false,
                        "aliases": [
                          "active"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "active": {
                        "attrOrProp": 1,
                        "digest": "Turn metronome off or on (0, 1).",
                        "isalias": true,
                        "aliasOf": "on",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "interval": {
                        "attrOrProp": 1,
                        "digest": "Metronome interval (ms or time value).",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "500"
                      },
                      "tickout": {
                        "attrOrProp": 1,
                        "digest": "metronome output",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "bang"
                      },
                      "lock": {
                        "attrOrProp": 2,
                        "digest": "Lock to transport.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0"
                      }
                    },
                    "inputs": [
                      {
                        "name": "on",
                        "type": "number",
                        "digest": "Turn metronome off or on (0, 1).",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "interval",
                        "type": "number",
                        "digest": "Metronome interval (ms or time value).",
                        "defaultarg": 1,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "tickout",
                        "type": "bang",
                        "digest": "metronome output",
                        "docked": false
                      }
                    ],
                    "helpname": "metro",
                    "aliasOf": "metro",
                    "classname": "metro",
                    "operator": false,
                    "versionId": 0,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "metro",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "interval": 180
                  }
                }
              },
              {
                "box": {
                  "id": "obj-16",
                  "text": "counter 0 7",
                  "patching_rect": [
                    865,
                    228,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "counter_obj-16",
                  "rnbo_serial": 15,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "carryflag": {
                        "attrOrProp": 1,
                        "digest": "Set underflow/overflow output type",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "enum": [
                          "numeric",
                          "bang"
                        ],
                        "type": "enum",
                        "defaultValue": "numeric"
                      },
                      "input": {
                        "attrOrProp": 1,
                        "digest": "numbers or bangs here are counted",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "bang"
                      },
                      "direction": {
                        "attrOrProp": 1,
                        "digest": "Set Direction: 0 = Up, 1 = Down, 2 = UpDown",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "resetnext": {
                        "attrOrProp": 1,
                        "digest": "Reset Counter to Number on Next Clock",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "resetnow": {
                        "attrOrProp": 1,
                        "digest": "Reset Counter to Number Immediately",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "maximum": {
                        "attrOrProp": 1,
                        "digest": "Set Maximum",
                        "defaultarg": 2,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "9999999"
                      },
                      "output": {
                        "attrOrProp": 1,
                        "digest": "Current Count",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "underflow": {
                        "attrOrProp": 1,
                        "digest": "Underflow (Counter Hit Minimum)",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "overflow": {
                        "attrOrProp": 1,
                        "digest": "Overflow (Counter Hit Maximum)",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "carry": {
                        "attrOrProp": 1,
                        "digest": "Carry Count",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "minimum": {
                        "attrOrProp": 1,
                        "digest": "minimum",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "inc": {
                        "attrOrProp": 2,
                        "digest": "Increment",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "1"
                      }
                    },
                    "inputs": [
                      {
                        "name": "input",
                        "type": "bang",
                        "digest": "numbers or bangs here are counted",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "direction",
                        "type": "number",
                        "digest": "Set Direction: 0 = Up, 1 = Down, 2 = UpDown",
                        "docked": false
                      },
                      {
                        "name": "resetnext",
                        "type": [
                          "number",
                          "bang"
                        ],
                        "digest": "Reset Counter to Number on Next Clock",
                        "docked": false
                      },
                      {
                        "name": "resetnow",
                        "type": [
                          "number",
                          "bang"
                        ],
                        "digest": "Reset Counter to Number Immediately",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "maximum",
                        "type": "number",
                        "digest": "Set Maximum",
                        "defaultarg": 2,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "output",
                        "type": "number",
                        "digest": "Current Count",
                        "docked": false
                      },
                      {
                        "name": "underflow",
                        "type": [
                          "bang",
                          "number"
                        ],
                        "digest": "Underflow (Counter Hit Minimum)",
                        "docked": false
                      },
                      {
                        "name": "overflow",
                        "type": [
                          "bang",
                          "number"
                        ],
                        "digest": "Overflow (Counter Hit Maximum)",
                        "docked": false
                      },
                      {
                        "name": "carry",
                        "type": "number",
                        "digest": "Carry Count",
                        "docked": false
                      }
                    ],
                    "helpname": "counter",
                    "aliasOf": "counter",
                    "classname": "counter",
                    "operator": false,
                    "versionId": -784425294,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "counter",
                  "numinlets": 5,
                  "numoutlets": 4,
                  "outlettype": [
                    "",
                    "",
                    "",
                    ""
                  ],
                  "rnbo_extra_attributes": {}
                }
              },
              {
                "box": {
                  "id": "obj-17",
                  "text": "+ @hot 1",
                  "patching_rect": [
                    25,
                    294,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr_obj-17",
                  "rnbo_serial": 16,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in2": {
                        "attrOrProp": 1,
                        "digest": "in2",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "doNotShowInMaxInspector": true
                      },
                      "hot": {
                        "attrOrProp": 2,
                        "digest": "Trigger computation on all inlets.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "number",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": "number",
                        "digest": "in2",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "number",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr",
                    "aliasOf": "expr",
                    "classname": "expr",
                    "operator": false,
                    "versionId": 835263063,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "hot": true,
                    "serialclassname": "+",
                    "expr": "out1 = in1+in2",
                    "isConvertedOperator": true,
                    "cold": false
                  }
                }
              },
              {
                "box": {
                  "id": "obj-18",
                  "text": "% 8",
                  "patching_rect": [
                    305,
                    294,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr_obj-18",
                  "rnbo_serial": 17,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in2": {
                        "attrOrProp": 1,
                        "digest": "in2",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "8"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "doNotShowInMaxInspector": true
                      },
                      "hot": {
                        "attrOrProp": 2,
                        "digest": "Trigger computation on all inlets.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "number",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": "number",
                        "digest": "in2",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "number",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr",
                    "aliasOf": "expr",
                    "classname": "expr",
                    "operator": false,
                    "versionId": 835263063,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "in2": 8,
                    "serialclassname": "%",
                    "expr": "out1 = safemod(in1,in2)",
                    "isConvertedOperator": true,
                    "cold": true
                  }
                }
              },
              {
                "box": {
                  "id": "obj-19",
                  "text": "* @hot 1",
                  "patching_rect": [
                    585,
                    294,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr_obj-19",
                  "rnbo_serial": 18,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in2": {
                        "attrOrProp": 1,
                        "digest": "in2",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "doNotShowInMaxInspector": true
                      },
                      "hot": {
                        "attrOrProp": 2,
                        "digest": "Trigger computation on all inlets.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "number",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": "number",
                        "digest": "in2",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "number",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr",
                    "aliasOf": "expr",
                    "classname": "expr",
                    "operator": false,
                    "versionId": 835263063,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "hot": true,
                    "serialclassname": "*",
                    "expr": "out1 = in1*in2",
                    "isConvertedOperator": true,
                    "cold": false
                  }
                }
              },
              {
                "box": {
                  "id": "obj-20",
                  "text": "+ @hot 1",
                  "patching_rect": [
                    865,
                    294,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr_obj-20",
                  "rnbo_serial": 19,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in2": {
                        "attrOrProp": 1,
                        "digest": "in2",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "doNotShowInMaxInspector": true
                      },
                      "hot": {
                        "attrOrProp": 2,
                        "digest": "Trigger computation on all inlets.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "number",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": "number",
                        "digest": "in2",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "number",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr",
                    "aliasOf": "expr",
                    "classname": "expr",
                    "operator": false,
                    "versionId": 835263063,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "hot": true,
                    "serialclassname": "+",
                    "expr": "out1 = in1+in2",
                    "isConvertedOperator": true,
                    "cold": false
                  }
                }
              },
              {
                "box": {
                  "id": "obj-21",
                  "text": "expr 440. * exp((in1 - 69.) * 0.0577622650466621)",
                  "patching_rect": [
                    25,
                    360,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr_obj-21",
                  "rnbo_serial": 20,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "doNotShowInMaxInspector": true
                      },
                      "hot": {
                        "attrOrProp": 2,
                        "digest": "Trigger computation on all inlets.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "number",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "number",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr",
                    "aliasOf": "expr",
                    "classname": "expr",
                    "operator": false,
                    "versionId": 835263063,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "expr": [
                      440,
                      "*",
                      "exp((in1",
                      "-",
                      "69.)",
                      "*",
                      "0.0577622650466621)"
                    ]
                  }
                }
              },
              {
                "box": {
                  "id": "obj-22",
                  "text": "pack 0. 25.",
                  "patching_rect": [
                    305,
                    360,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "pack_obj-22",
                  "rnbo_serial": 21,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "out": {
                        "attrOrProp": 1,
                        "digest": "out",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "list"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 1",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in2": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 2",
                        "defaultarg": 2,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "length": {
                        "attrOrProp": 2,
                        "digest": "how many things to pack",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number"
                      },
                      "list": {
                        "attrOrProp": 2,
                        "digest": "the list to initialize the {@objectname} object with",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "list"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": [
                          "number",
                          "bang"
                        ],
                        "digest": "number to be list element 1",
                        "defaultarg": 1,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": "number",
                        "digest": "number to be list element 2",
                        "defaultarg": 2,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out",
                        "type": "list",
                        "digest": "out",
                        "docked": false
                      }
                    ],
                    "helpname": "pack",
                    "aliasOf": "pack",
                    "classname": "pack",
                    "operator": false,
                    "versionId": 1331432417,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "pack",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {}
                }
              },
              {
                "box": {
                  "id": "obj-23",
                  "text": "line~",
                  "patching_rect": [
                    585,
                    360,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "line~_obj-23",
                  "rnbo_serial": 22,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "segments": {
                        "attrOrProp": 1,
                        "digest": "Target value or target value/ramp time pairs",
                        "isalias": false,
                        "aliases": [
                          "dest"
                        ],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "list",
                        "defaultValue": ""
                      },
                      "dest": {
                        "attrOrProp": 1,
                        "digest": "Target value or target value/ramp time pairs",
                        "isalias": true,
                        "aliasOf": "segments",
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "list",
                        "defaultValue": ""
                      },
                      "time": {
                        "attrOrProp": 1,
                        "digest": "Ramp time",
                        "defaultarg": 2,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "keepramp": {
                        "attrOrProp": 1,
                        "digest": "Keep last ramp",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "out": {
                        "attrOrProp": 1,
                        "digest": "Ramp out",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "signal"
                      },
                      "target": {
                        "attrOrProp": 1,
                        "digest": "Bang when ramp has finished",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "bang"
                      },
                      "value": {
                        "attrOrProp": 2,
                        "digest": "Initial value.",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0"
                      }
                    },
                    "inputs": [
                      {
                        "name": "segments",
                        "type": "list",
                        "digest": "Target value or target value/ramp time pairs",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "time",
                        "type": "number",
                        "digest": "Ramp time",
                        "defaultarg": 2,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out",
                        "type": "signal",
                        "digest": "Ramp out",
                        "docked": false
                      },
                      {
                        "name": "target",
                        "type": "bang",
                        "digest": "Bang when ramp has finished",
                        "docked": false
                      }
                    ],
                    "helpname": "line~",
                    "aliasOf": "line~",
                    "classname": "line~",
                    "operator": false,
                    "versionId": 2134689829,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "line~",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "rnbo_extra_attributes": {}
                }
              },
              {
                "box": {
                  "id": "obj-24",
                  "text": "cycle~",
                  "patching_rect": [
                    865,
                    360,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "cycle~_obj-24",
                  "rnbo_serial": 23,
                  "rnboinfo": {
                    "needsInstanceInfo": false,
                    "argnames": {
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "Output",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "signal"
                      },
                      "out2": {
                        "attrOrProp": 1,
                        "digest": "Phase",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "signal"
                      },
                      "frequency": {
                        "attrOrProp": 1,
                        "digest": "Frequency or phase",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "phase_offset": {
                        "attrOrProp": 1,
                        "digest": "phase offset amount (0. - 1.)",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "buffer": {
                        "attrOrProp": 1,
                        "digest": "If multiple buffer names are declared to be used, this sets the currently active buffer using an index [0 based].",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Banging this attribute will reset the current phase to 0.",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang",
                        "defaultValue": "0"
                      },
                      "index": {
                        "attrOrProp": 2,
                        "digest": "index mode, freq/phase for being driven by frequency or a phasor",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "enum": [
                          "freq",
                          "phase",
                          "both"
                        ],
                        "type": "enum",
                        "defaultValue": "freq"
                      },
                      "interp": {
                        "attrOrProp": 2,
                        "digest": "interpolation mode",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "enum": [
                          "linear",
                          "cubic",
                          "spline",
                          "cosine",
                          "step",
                          "none",
                          "fastcubic",
                          "spline6"
                        ],
                        "type": "enum",
                        "defaultValue": "linear"
                      },
                      "buffername": {
                        "attrOrProp": 2,
                        "digest": "buffer to read the wavetable from (default: sinus)",
                        "defaultarg": 2,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "RNBODefaultSinus"
                      }
                    },
                    "inputs": [
                      {
                        "name": "frequency",
                        "type": "auto",
                        "digest": "Frequency or phase",
                        "displayName": "frequency",
                        "defaultarg": 1,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "phase_offset",
                        "type": "auto",
                        "digest": "phase offset amount (0. - 1.)",
                        "displayName": "phase_offset",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "signal",
                        "digest": "Output",
                        "docked": false
                      },
                      {
                        "name": "out2",
                        "type": "signal",
                        "digest": "Phase",
                        "docked": false
                      }
                    ],
                    "helpname": "cycle~",
                    "aliasOf": "cycle~",
                    "classname": "cycle~",
                    "operator": false,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "cycle~",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    "signal"
                  ],
                  "rnbo_extra_attributes": {}
                }
              },
              {
                "box": {
                  "id": "obj-25",
                  "text": "expr 2. * min(1. - in1, 0.5)",
                  "patching_rect": [
                    25,
                    426,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr_obj-25",
                  "rnbo_serial": 24,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "doNotShowInMaxInspector": true
                      },
                      "hot": {
                        "attrOrProp": 2,
                        "digest": "Trigger computation on all inlets.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "number",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "number",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr",
                    "aliasOf": "expr",
                    "classname": "expr",
                    "operator": false,
                    "versionId": 835263063,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "expr": [
                      2,
                      "*",
                      "min(1.",
                      "-",
                      "in1,",
                      "0.5)"
                    ]
                  }
                }
              },
              {
                "box": {
                  "id": "obj-26",
                  "text": "expr 2. * min(in1, 0.5)",
                  "patching_rect": [
                    305,
                    426,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr_obj-26",
                  "rnbo_serial": 25,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "doNotShowInMaxInspector": true
                      },
                      "hot": {
                        "attrOrProp": 2,
                        "digest": "Trigger computation on all inlets.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "number",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "number",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr",
                    "aliasOf": "expr",
                    "classname": "expr",
                    "operator": false,
                    "versionId": 835263063,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "expr": [
                      2,
                      "*",
                      "min(in1,",
                      "0.5)"
                    ]
                  }
                }
              },
              {
                "box": {
                  "id": "obj-27",
                  "text": "*~",
                  "patching_rect": [
                    585,
                    426,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr~_obj-27",
                  "rnbo_serial": 26,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in2": {
                        "attrOrProp": 1,
                        "digest": "in2",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "signal"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "auto",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": "auto",
                        "digest": "in2",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "signal",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr~",
                    "aliasOf": "expr~",
                    "classname": "expr~",
                    "operator": false,
                    "versionId": 527839773,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr~",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "rnbo_extra_attributes": {
                    "serialclassname": "*~",
                    "expr": "out1 = in1*in2",
                    "isConvertedOperator": true,
                    "cold": true
                  }
                }
              },
              {
                "box": {
                  "id": "obj-28",
                  "text": "*~",
                  "patching_rect": [
                    865,
                    426,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr~_obj-28",
                  "rnbo_serial": 27,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in2": {
                        "attrOrProp": 1,
                        "digest": "in2",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "signal"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "auto",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": "auto",
                        "digest": "in2",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "signal",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr~",
                    "aliasOf": "expr~",
                    "classname": "expr~",
                    "operator": false,
                    "versionId": 527839773,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr~",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "rnbo_extra_attributes": {
                    "serialclassname": "*~",
                    "expr": "out1 = in1*in2",
                    "isConvertedOperator": true,
                    "cold": true
                  }
                }
              },
              {
                "box": {
                  "id": "obj-29",
                  "text": "*~",
                  "patching_rect": [
                    25,
                    492,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr~_obj-29",
                  "rnbo_serial": 28,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in2": {
                        "attrOrProp": 1,
                        "digest": "in2",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "signal"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "auto",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": "auto",
                        "digest": "in2",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "signal",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr~",
                    "aliasOf": "expr~",
                    "classname": "expr~",
                    "operator": false,
                    "versionId": 527839773,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr~",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "rnbo_extra_attributes": {
                    "serialclassname": "*~",
                    "expr": "out1 = in1*in2",
                    "isConvertedOperator": true,
                    "cold": true
                  }
                }
              },
              {
                "box": {
                  "id": "obj-30",
                  "text": "*~",
                  "patching_rect": [
                    305,
                    492,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr~_obj-30",
                  "rnbo_serial": 29,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in2": {
                        "attrOrProp": 1,
                        "digest": "in2",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "signal"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "auto",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": "auto",
                        "digest": "in2",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "signal",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr~",
                    "aliasOf": "expr~",
                    "classname": "expr~",
                    "operator": false,
                    "versionId": 527839773,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr~",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "rnbo_extra_attributes": {
                    "serialclassname": "*~",
                    "expr": "out1 = in1*in2",
                    "isConvertedOperator": true,
                    "cold": true
                  }
                }
              },
              {
                "box": {
                  "id": "obj-31",
                  "text": "clip~ -0.8 0.8",
                  "patching_rect": [
                    585,
                    492,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr~_obj-31",
                  "rnbo_serial": 30,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in2": {
                        "attrOrProp": 1,
                        "digest": "in2",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "-0.8"
                      },
                      "in3": {
                        "attrOrProp": 1,
                        "digest": "in3",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0.8"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "signal"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "auto",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": "auto",
                        "digest": "in2",
                        "docked": false
                      },
                      {
                        "name": "in3",
                        "type": "auto",
                        "digest": "in3",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "signal",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr~",
                    "aliasOf": "expr~",
                    "classname": "expr~",
                    "operator": false,
                    "versionId": 527839773,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr~",
                  "numinlets": 3,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "rnbo_extra_attributes": {
                    "in2": -0.8,
                    "in3": 0.8,
                    "serialclassname": "clip~",
                    "expr": "out1 = in1 > in3 ? in3 : (in1 < in2 ? in2 : in1)",
                    "isConvertedOperator": true,
                    "cold": true
                  }
                }
              },
              {
                "box": {
                  "id": "obj-32",
                  "text": "out~ 1",
                  "patching_rect": [
                    865,
                    492,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "out~_obj-32",
                  "rnbo_serial": 31,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "signal sent to outlet with index 1",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "signal"
                      },
                      "index": {
                        "attrOrProp": 2,
                        "digest": "outlet number",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "mandatory": true
                      },
                      "comment": {
                        "attrOrProp": 2,
                        "digest": "mouse over comment",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol"
                      },
                      "meta": {
                        "attrOrProp": 2,
                        "digest": "A JSON formatted string containing metadata for use by the exported code",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Metadata",
                        "displayorder": 3
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "signal",
                        "digest": "signal sent to outlet with index 1",
                        "displayName": "",
                        "hot": true,
                        "docked": false
                      }
                    ],
                    "outputs": [],
                    "helpname": "out~",
                    "aliasOf": "out~",
                    "classname": "out~",
                    "operator": false,
                    "versionId": 1989326771,
                    "changesPatcherIO": true
                  },
                  "rnbo_classname": "out~",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "rnbo_extra_attributes": {
                    "index": 1
                  }
                }
              },
              {
                "box": {
                  "id": "obj-33",
                  "text": "*~",
                  "patching_rect": [
                    25,
                    558,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr~_obj-33",
                  "rnbo_serial": 32,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in2": {
                        "attrOrProp": 1,
                        "digest": "in2",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "signal"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "auto",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": "auto",
                        "digest": "in2",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "signal",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr~",
                    "aliasOf": "expr~",
                    "classname": "expr~",
                    "operator": false,
                    "versionId": 527839773,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr~",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "rnbo_extra_attributes": {
                    "serialclassname": "*~",
                    "expr": "out1 = in1*in2",
                    "isConvertedOperator": true,
                    "cold": true
                  }
                }
              },
              {
                "box": {
                  "id": "obj-34",
                  "text": "*~",
                  "patching_rect": [
                    305,
                    558,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr~_obj-34",
                  "rnbo_serial": 33,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in2": {
                        "attrOrProp": 1,
                        "digest": "in2",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "signal"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "auto",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": "auto",
                        "digest": "in2",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "signal",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr~",
                    "aliasOf": "expr~",
                    "classname": "expr~",
                    "operator": false,
                    "versionId": 527839773,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr~",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "rnbo_extra_attributes": {
                    "serialclassname": "*~",
                    "expr": "out1 = in1*in2",
                    "isConvertedOperator": true,
                    "cold": true
                  }
                }
              },
              {
                "box": {
                  "id": "obj-35",
                  "text": "clip~ -0.8 0.8",
                  "patching_rect": [
                    585,
                    558,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr~_obj-35",
                  "rnbo_serial": 34,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Reset all state and params to initial values",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "in1",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in2": {
                        "attrOrProp": 1,
                        "digest": "in2",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "-0.8"
                      },
                      "in3": {
                        "attrOrProp": 1,
                        "digest": "in3",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0.8"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "out1",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "signal"
                      },
                      "expr": {
                        "attrOrProp": 2,
                        "digest": "expr",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol"
                      },
                      "safemath": {
                        "attrOrProp": 2,
                        "digest": "Use safe math expressions (e.g.: division by 0 will not crash).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "true"
                      },
                      "nocache": {
                        "attrOrProp": 2,
                        "digest": "Do not use parsing cache. This is only useful with very very big code sizes. Code generation will then take a looooong time.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "auto",
                        "digest": "in1",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": "auto",
                        "digest": "in2",
                        "docked": false
                      },
                      {
                        "name": "in3",
                        "type": "auto",
                        "digest": "in3",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "signal",
                        "digest": "out1",
                        "docked": false
                      }
                    ],
                    "helpname": "expr~",
                    "aliasOf": "expr~",
                    "classname": "expr~",
                    "operator": false,
                    "versionId": 527839773,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "expr~",
                  "numinlets": 3,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "rnbo_extra_attributes": {
                    "in2": -0.8,
                    "in3": 0.8,
                    "serialclassname": "clip~",
                    "expr": "out1 = in1 > in3 ? in3 : (in1 < in2 ? in2 : in1)",
                    "isConvertedOperator": true,
                    "cold": true
                  }
                }
              },
              {
                "box": {
                  "id": "obj-36",
                  "text": "out~ 2",
                  "patching_rect": [
                    865,
                    558,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "out~_obj-36",
                  "rnbo_serial": 35,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "signal sent to outlet with index 2",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "signal"
                      },
                      "index": {
                        "attrOrProp": 2,
                        "digest": "outlet number",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "mandatory": true
                      },
                      "comment": {
                        "attrOrProp": 2,
                        "digest": "mouse over comment",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol"
                      },
                      "meta": {
                        "attrOrProp": 2,
                        "digest": "A JSON formatted string containing metadata for use by the exported code",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "",
                        "label": "Metadata",
                        "displayorder": 3
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": "signal",
                        "digest": "signal sent to outlet with index 2",
                        "displayName": "",
                        "hot": true,
                        "docked": false
                      }
                    ],
                    "outputs": [],
                    "helpname": "out~",
                    "aliasOf": "out~",
                    "classname": "out~",
                    "operator": false,
                    "versionId": 1989326771,
                    "changesPatcherIO": true
                  },
                  "rnbo_classname": "out~",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "rnbo_extra_attributes": {
                    "index": 2
                  }
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "obj-10",
                    0
                  ],
                  "destination": [
                    "obj-11",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-10",
                    1
                  ],
                  "destination": [
                    "obj-12",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-12",
                    0
                  ],
                  "destination": [
                    "obj-13",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-8",
                    0
                  ],
                  "destination": [
                    "obj-13",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-9",
                    0
                  ],
                  "destination": [
                    "obj-13",
                    4
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-12",
                    0
                  ],
                  "destination": [
                    "obj-14",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-14",
                    0
                  ],
                  "destination": [
                    "obj-15",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-3",
                    0
                  ],
                  "destination": [
                    "obj-15",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-15",
                    0
                  ],
                  "destination": [
                    "obj-16",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-16",
                    0
                  ],
                  "destination": [
                    "obj-17",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-6",
                    0
                  ],
                  "destination": [
                    "obj-17",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-17",
                    0
                  ],
                  "destination": [
                    "obj-18",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-18",
                    0
                  ],
                  "destination": [
                    "obj-19",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-4",
                    0
                  ],
                  "destination": [
                    "obj-19",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-10",
                    0
                  ],
                  "destination": [
                    "obj-20",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-19",
                    0
                  ],
                  "destination": [
                    "obj-20",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-20",
                    0
                  ],
                  "destination": [
                    "obj-21",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-21",
                    0
                  ],
                  "destination": [
                    "obj-22",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-5",
                    0
                  ],
                  "destination": [
                    "obj-22",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-22",
                    0
                  ],
                  "destination": [
                    "obj-23",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-23",
                    0
                  ],
                  "destination": [
                    "obj-24",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-7",
                    0
                  ],
                  "destination": [
                    "obj-25",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-7",
                    0
                  ],
                  "destination": [
                    "obj-26",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-24",
                    0
                  ],
                  "destination": [
                    "obj-27",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-26",
                    0
                  ],
                  "destination": [
                    "obj-27",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-24",
                    0
                  ],
                  "destination": [
                    "obj-28",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-25",
                    0
                  ],
                  "destination": [
                    "obj-28",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-28",
                    0
                  ],
                  "destination": [
                    "obj-29",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-13",
                    0
                  ],
                  "destination": [
                    "obj-29",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-29",
                    0
                  ],
                  "destination": [
                    "obj-30",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-2",
                    0
                  ],
                  "destination": [
                    "obj-30",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-30",
                    0
                  ],
                  "destination": [
                    "obj-31",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-31",
                    0
                  ],
                  "destination": [
                    "obj-32",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-27",
                    0
                  ],
                  "destination": [
                    "obj-33",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-13",
                    0
                  ],
                  "destination": [
                    "obj-33",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-33",
                    0
                  ],
                  "destination": [
                    "obj-34",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-2",
                    0
                  ],
                  "destination": [
                    "obj-34",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-34",
                    0
                  ],
                  "destination": [
                    "obj-35",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-35",
                    0
                  ],
                  "destination": [
                    "obj-36",
                    0
                  ]
                }
              }
            ],
            "appversion": {
              "major": 9,
              "minor": 0,
              "revision": 9,
              "architecture": "arm64",
              "modernui": 1
            },
            "default_fontname": "Arial",
            "default_fontsize": 12
          },
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "signal",
            "signal",
            "list"
          ],
          "inletInfo": {
            "IOInfo": []
          },
          "outletInfo": {
            "IOInfo": [
              {
                "type": "signal",
                "index": 1,
                "tag": "",
                "comment": ""
              },
              {
                "type": "signal",
                "index": 2,
                "tag": "",
                "comment": ""
              }
            ]
          },
          "rnboversion": "1.4.4",
          "rnboattrcache": {},
          "saved_object_attributes": {
            "optimization": "O1",
            "parameter_enable": 0
          }
        }
      },
      {
        "box": {
          "id": "obj-3",
          "maxclass": "ezdac~",
          "patching_rect": [
            40,
            240,
            45,
            45
          ],
          "numinlets": 2,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "obj-4",
          "maxclass": "comment",
          "text": "RNBO FM1 module. Audio starts OFF. Edit inside rnbo~; save the RNBO subpatch as .rnbopat before building.",
          "patching_rect": [
            230,
            40,
            360,
            90
          ],
          "linecount": 4,
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": []
        }
      },
      {
        "box": {
          "id": "obj-5",
          "maxclass": "message",
          "text": "level 0.12",
          "patching_rect": [
            240,
            140,
            180,
            22
          ],
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ]
        }
      },
      {
        "box": {
          "id": "obj-6",
          "maxclass": "message",
          "text": "period 180",
          "patching_rect": [
            240,
            175,
            180,
            22
          ],
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ]
        }
      },
      {
        "box": {
          "id": "obj-7",
          "maxclass": "message",
          "text": "interval 2",
          "patching_rect": [
            240,
            210,
            180,
            22
          ],
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ]
        }
      },
      {
        "box": {
          "id": "obj-8",
          "maxclass": "message",
          "text": "glide 25",
          "patching_rect": [
            240,
            245,
            180,
            22
          ],
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ]
        }
      },
      {
        "box": {
          "id": "obj-9",
          "maxclass": "message",
          "text": "rotate 0",
          "patching_rect": [
            430,
            140,
            180,
            22
          ],
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ]
        }
      },
      {
        "box": {
          "id": "obj-10",
          "maxclass": "message",
          "text": "pan 0.5",
          "patching_rect": [
            430,
            175,
            180,
            22
          ],
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ]
        }
      },
      {
        "box": {
          "id": "obj-11",
          "maxclass": "message",
          "text": "attack 8",
          "patching_rect": [
            430,
            210,
            180,
            22
          ],
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ]
        }
      },
      {
        "box": {
          "id": "obj-12",
          "maxclass": "message",
          "text": "release 180",
          "patching_rect": [
            430,
            245,
            180,
            22
          ],
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ]
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "source": [
            "obj-1",
            0
          ],
          "destination": [
            "obj-2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-2",
            0
          ],
          "destination": [
            "obj-3",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-2",
            1
          ],
          "destination": [
            "obj-3",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-5",
            0
          ],
          "destination": [
            "obj-2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-6",
            0
          ],
          "destination": [
            "obj-2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-7",
            0
          ],
          "destination": [
            "obj-2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-8",
            0
          ],
          "destination": [
            "obj-2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-9",
            0
          ],
          "destination": [
            "obj-2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-10",
            0
          ],
          "destination": [
            "obj-2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-11",
            0
          ],
          "destination": [
            "obj-2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-12",
            0
          ],
          "destination": [
            "obj-2",
            0
          ]
        }
      }
    ],
    "classnamespace": "box",
    "default_fontname": "Arial",
    "default_fontsize": 12
  }
}
