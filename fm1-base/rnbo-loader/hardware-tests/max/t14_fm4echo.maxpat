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
              50,
              50,
              1100,
              800
            ],
            "boxes": [
              {
                "box": {
                  "id": "obj-1",
                  "maxclass": "newobj",
                  "text": "param ratio 2.0 @min 0.25 @max 8.0 @displayorder 2 @displayname \"Ratio\"",
                  "patching_rect": [
                    20,
                    25,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "ratio",
                  "rnbo_serial": 0,
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
                    "name": "ratio",
                    "value": 2,
                    "min": 0.25,
                    "max": 8,
                    "displayorder": 2,
                    "displayname": "Ratio"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-2",
                  "maxclass": "newobj",
                  "text": "param attack 10.0 @min 1.0 @max 1000.0 @displayorder 7 @displayname \"Attack\"",
                  "patching_rect": [
                    280,
                    25,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "attack",
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
                    "name": "attack",
                    "value": 10,
                    "min": 1,
                    "max": 1000,
                    "displayorder": 7,
                    "displayname": "Attack"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-3",
                  "maxclass": "newobj",
                  "text": "param depth 1.5 @min 0.0 @max 8.0 @displayorder 3 @displayname \"Depth\"",
                  "patching_rect": [
                    540,
                    25,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "depth",
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
                    "name": "depth",
                    "value": 1.5,
                    "min": 0,
                    "max": 8,
                    "displayorder": 3,
                    "displayname": "Depth"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-4",
                  "maxclass": "newobj",
                  "text": "param release 150.0 @min 1.0 @max 2000.0 @displayorder 8 @displayname \"Release\"",
                  "patching_rect": [
                    800,
                    25,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "release",
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
                    "name": "release",
                    "value": 150,
                    "min": 1,
                    "max": 2000,
                    "displayorder": 8,
                    "displayname": "Release"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-5",
                  "maxclass": "newobj",
                  "text": "param level 0.075 @min 0.0 @max 0.125 @displayorder 1 @displayname \"Level\"",
                  "patching_rect": [
                    20,
                    70,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "level",
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
                    "name": "level",
                    "value": 0.075,
                    "min": 0,
                    "max": 0.125,
                    "displayorder": 1,
                    "displayname": "Level"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-6",
                  "maxclass": "newobj",
                  "text": "param echo_time 120.0 @min 40.0 @max 170.0 @displayorder 4 @displayname \"Echo Time\"",
                  "patching_rect": [
                    280,
                    70,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "echo_time",
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
                    "name": "echo_time",
                    "value": 120,
                    "min": 40,
                    "max": 170,
                    "displayorder": 4,
                    "displayname": "Echo Time"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-7",
                  "maxclass": "newobj",
                  "text": "param echo_feedback 0.45 @min 0.0 @max 0.98 @displayorder 5 @displayname \"Echo Feedback\"",
                  "patching_rect": [
                    540,
                    70,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "echo_feedback",
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
                    "name": "echo_feedback",
                    "value": 0.45,
                    "min": 0,
                    "max": 0.98,
                    "displayorder": 5,
                    "displayname": "Echo Feedback"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-8",
                  "maxclass": "newobj",
                  "text": "param echo_mix 0.28 @min 0.0 @max 1.0 @displayorder 6 @displayname \"Echo Mix\"",
                  "patching_rect": [
                    800,
                    70,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "echo_mix",
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
                    "name": "echo_mix",
                    "value": 0.28,
                    "min": 0,
                    "max": 1,
                    "displayorder": 6,
                    "displayname": "Echo Mix"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-9",
                  "maxclass": "newobj",
                  "text": "p synth @polyphony 4 @voicecontrol midi",
                  "patching_rect": [
                    20,
                    180,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "synth",
                  "rnbo_serial": 8,
                  "patcher": {
                    "fileversion": 1,
                    "classnamespace": "rnbo",
                    "rect": [
                      100,
                      100,
                      900,
                      650
                    ],
                    "boxes": [
                      {
                        "box": {
                          "id": "obj-1",
                          "maxclass": "newobj",
                          "text": "in 1",
                          "patching_rect": [
                            40,
                            240,
                            170,
                            22
                          ],
                          "rnbo_uniqueid": "fm0",
                          "rnbo_serial": 30,
                          "rnboinfo": {
                            "needsInstanceInfo": true,
                            "argnames": {
                              "index": {
                                "attrOrProp": 2,
                                "digest": "inlet number",
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
                            "inputs": [],
                            "outputs": [
                              {
                                "name": "out1",
                                "type": [
                                  "bang",
                                  "number",
                                  "list"
                                ],
                                "digest": "value from inlet with index 1",
                                "displayName": "",
                                "docked": false
                              }
                            ],
                            "helpname": "in",
                            "aliasOf": "in",
                            "classname": "in",
                            "operator": false,
                            "versionId": 475235762,
                            "changesPatcherIO": true
                          },
                          "rnbo_classname": "in",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "rnbo_extra_attributes": {
                            "index": 1
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-2",
                          "maxclass": "newobj",
                          "text": "in 3",
                          "patching_rect": [
                            240,
                            240,
                            170,
                            22
                          ],
                          "rnbo_uniqueid": "fm1",
                          "rnbo_serial": 31,
                          "rnboinfo": {
                            "needsInstanceInfo": true,
                            "argnames": {
                              "index": {
                                "attrOrProp": 2,
                                "digest": "inlet number",
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
                            "inputs": [],
                            "outputs": [
                              {
                                "name": "out1",
                                "type": [
                                  "bang",
                                  "number",
                                  "list"
                                ],
                                "digest": "value from inlet with index 3",
                                "displayName": "",
                                "docked": false
                              }
                            ],
                            "helpname": "in",
                            "aliasOf": "in",
                            "classname": "in",
                            "operator": false,
                            "versionId": 475235762,
                            "changesPatcherIO": true
                          },
                          "rnbo_classname": "in",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "rnbo_extra_attributes": {
                            "index": 3
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-3",
                          "maxclass": "newobj",
                          "text": "in 2",
                          "rnbo_uniqueid": "p10",
                          "rnbo_serial": 10,
                          "patching_rect": [
                            220,
                            295,
                            160,
                            22
                          ],
                          "rnboinfo": {
                            "needsInstanceInfo": true,
                            "argnames": {
                              "index": {
                                "attrOrProp": 2,
                                "digest": "inlet number",
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
                            "inputs": [],
                            "outputs": [
                              {
                                "name": "out1",
                                "type": [
                                  "bang",
                                  "number",
                                  "list"
                                ],
                                "digest": "value from inlet with index 2",
                                "displayName": "",
                                "docked": false
                              }
                            ],
                            "helpname": "in",
                            "aliasOf": "in",
                            "classname": "in",
                            "operator": false,
                            "versionId": 475235762,
                            "changesPatcherIO": true
                          },
                          "rnbo_classname": "in",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "rnbo_extra_attributes": {
                            "index": 2
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-4",
                          "maxclass": "newobj",
                          "text": "in 4",
                          "rnbo_uniqueid": "p11",
                          "rnbo_serial": 11,
                          "patching_rect": [
                            400,
                            295,
                            160,
                            22
                          ],
                          "rnboinfo": {
                            "needsInstanceInfo": true,
                            "argnames": {
                              "index": {
                                "attrOrProp": 2,
                                "digest": "inlet number",
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
                            "inputs": [],
                            "outputs": [
                              {
                                "name": "out1",
                                "type": [
                                  "bang",
                                  "number",
                                  "list"
                                ],
                                "digest": "value from inlet with index 4",
                                "displayName": "",
                                "docked": false
                              }
                            ],
                            "helpname": "in",
                            "aliasOf": "in",
                            "classname": "in",
                            "operator": false,
                            "versionId": 475235762,
                            "changesPatcherIO": true
                          },
                          "rnbo_classname": "in",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "rnbo_extra_attributes": {
                            "index": 4
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-5",
                          "maxclass": "newobj",
                          "text": "notein",
                          "rnbo_classname": "notein",
                          "rnbo_uniqueid": "p0",
                          "rnbo_serial": 0,
                          "patching_rect": [
                            40,
                            40,
                            160,
                            22
                          ],
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
                          "id": "obj-6",
                          "maxclass": "newobj",
                          "text": "expr 440. * exp((in1 - 69.) * 0.0577622650466621)",
                          "rnbo_classname": "expr",
                          "rnbo_uniqueid": "p1",
                          "rnbo_serial": 1,
                          "patching_rect": [
                            220,
                            40,
                            160,
                            22
                          ],
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
                          "id": "obj-7",
                          "maxclass": "newobj",
                          "text": "cycle~",
                          "rnbo_classname": "cycle~",
                          "rnbo_uniqueid": "p2",
                          "rnbo_serial": 2,
                          "patching_rect": [
                            400,
                            40,
                            160,
                            22
                          ],
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
                          "id": "obj-8",
                          "maxclass": "newobj",
                          "text": "/ 127.",
                          "rnbo_classname": "expr",
                          "rnbo_uniqueid": "p3",
                          "rnbo_serial": 3,
                          "patching_rect": [
                            40,
                            125,
                            160,
                            22
                          ],
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
                          "id": "obj-9",
                          "maxclass": "newobj",
                          "text": "adsr~ 10 20 0.8 150",
                          "rnbo_classname": "adsr~",
                          "rnbo_uniqueid": "p4",
                          "rnbo_serial": 4,
                          "patching_rect": [
                            220,
                            125,
                            160,
                            22
                          ],
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
                          "numinlets": 5,
                          "numoutlets": 2,
                          "outlettype": [
                            "signal",
                            ""
                          ],
                          "rnbo_extra_attributes": {
                            "attack": 10,
                            "decay": 20,
                            "sustain": 0.8,
                            "release": 150
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-10",
                          "maxclass": "newobj",
                          "text": "*~",
                          "rnbo_classname": "expr~",
                          "rnbo_uniqueid": "p5",
                          "rnbo_serial": 5,
                          "patching_rect": [
                            400,
                            125,
                            160,
                            22
                          ],
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
                          "id": "obj-11",
                          "maxclass": "newobj",
                          "text": "*~ 0.2",
                          "rnbo_classname": "expr~",
                          "rnbo_uniqueid": "p7",
                          "rnbo_serial": 7,
                          "patching_rect": [
                            220,
                            210,
                            160,
                            22
                          ],
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
                                "defaultValue": "0.2"
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
                          "numinlets": 2,
                          "numoutlets": 1,
                          "outlettype": [
                            "signal"
                          ],
                          "rnbo_extra_attributes": {
                            "in2": 0.2,
                            "serialclassname": "*~",
                            "expr": "out1 = in1*in2",
                            "isConvertedOperator": true,
                            "cold": true
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-12",
                          "maxclass": "newobj",
                          "text": "out~ 1",
                          "rnbo_classname": "out~",
                          "rnbo_uniqueid": "p8",
                          "rnbo_serial": 8,
                          "patching_rect": [
                            400,
                            210,
                            160,
                            22
                          ],
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
                          "id": "obj-13",
                          "maxclass": "newobj",
                          "text": "out~ 2",
                          "rnbo_classname": "out~",
                          "rnbo_uniqueid": "p9",
                          "rnbo_serial": 9,
                          "patching_rect": [
                            40,
                            295,
                            160,
                            22
                          ],
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
                          "numinlets": 1,
                          "numoutlets": 0,
                          "outlettype": [],
                          "rnbo_extra_attributes": {
                            "index": 2
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-14",
                          "maxclass": "newobj",
                          "text": "* @hot 1",
                          "patching_rect": [
                            40,
                            290,
                            170,
                            22
                          ],
                          "rnbo_uniqueid": "fm2",
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
                          "id": "obj-15",
                          "maxclass": "newobj",
                          "text": "cycle~",
                          "patching_rect": [
                            40,
                            335,
                            170,
                            22
                          ],
                          "rnbo_uniqueid": "fm3",
                          "rnbo_serial": 33,
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
                          "id": "obj-16",
                          "maxclass": "newobj",
                          "text": "*~",
                          "patching_rect": [
                            230,
                            335,
                            170,
                            22
                          ],
                          "rnbo_uniqueid": "fm4",
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
                          "id": "obj-17",
                          "maxclass": "newobj",
                          "text": "* @hot 1",
                          "patching_rect": [
                            230,
                            290,
                            170,
                            22
                          ],
                          "rnbo_uniqueid": "fm5",
                          "rnbo_serial": 35,
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
                          "id": "obj-18",
                          "maxclass": "newobj",
                          "text": "+~",
                          "patching_rect": [
                            420,
                            335,
                            170,
                            22
                          ],
                          "rnbo_uniqueid": "fm6",
                          "rnbo_serial": 36,
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
                            "serialclassname": "+~",
                            "expr": "out1 = in1+in2",
                            "isConvertedOperator": true,
                            "cold": true
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-19",
                          "maxclass": "newobj",
                          "text": "in 5",
                          "patching_rect": [
                            40,
                            420,
                            250,
                            22
                          ],
                          "rnbo_uniqueid": "eight50",
                          "rnbo_serial": 50,
                          "rnboinfo": {
                            "needsInstanceInfo": true,
                            "argnames": {
                              "index": {
                                "attrOrProp": 2,
                                "digest": "inlet number",
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
                            "inputs": [],
                            "outputs": [
                              {
                                "name": "out1",
                                "type": [
                                  "bang",
                                  "number",
                                  "list"
                                ],
                                "digest": "value from inlet with index 5",
                                "displayName": "",
                                "docked": false
                              }
                            ],
                            "helpname": "in",
                            "aliasOf": "in",
                            "classname": "in",
                            "operator": false,
                            "versionId": 475235762,
                            "changesPatcherIO": true
                          },
                          "rnbo_classname": "in",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "rnbo_extra_attributes": {
                            "index": 5
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-20",
                          "maxclass": "newobj",
                          "text": "voice",
                          "patching_rect": [
                            680,
                            130,
                            100,
                            22
                          ],
                          "rnbo_uniqueid": "voice_sleep",
                          "rnbo_serial": 60,
                          "rnboinfo": {
                            "needsInstanceInfo": false,
                            "argnames": {
                              "voicebang": {
                                "attrOrProp": 1,
                                "digest": "Bang to report the current voice number.",
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
                              "mute": {
                                "attrOrProp": 1,
                                "digest": "Bang or 1 to mute voice, 0 to unmute.",
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
                              "muteout": {
                                "attrOrProp": 1,
                                "digest": "muteout",
                                "isalias": false,
                                "aliases": [],
                                "settable": false,
                                "attachable": true,
                                "isparam": false,
                                "deprecated": false,
                                "touched": false,
                                "type": "list"
                              },
                              "voicenumber": {
                                "attrOrProp": 1,
                                "digest": "The current voice index.",
                                "isalias": false,
                                "aliases": [],
                                "attachable": false,
                                "isparam": false,
                                "deprecated": false,
                                "touched": false,
                                "outlet": true,
                                "type": "number"
                              },
                              "noteNumber": {
                                "attrOrProp": 1,
                                "digest": "The current note number.",
                                "isalias": false,
                                "aliases": [],
                                "attachable": false,
                                "isparam": false,
                                "deprecated": false,
                                "touched": false,
                                "outlet": true,
                                "type": "number"
                              },
                              "mutestatus": {
                                "attrOrProp": 1,
                                "digest": "The current voice status.",
                                "isalias": false,
                                "aliases": [],
                                "attachable": false,
                                "isparam": false,
                                "deprecated": false,
                                "touched": false,
                                "outlet": true,
                                "type": "number"
                              },
                              "activevoices": {
                                "attrOrProp": 1,
                                "digest": "The number of currently active voices.",
                                "isalias": false,
                                "aliases": [],
                                "attachable": false,
                                "isparam": false,
                                "deprecated": false,
                                "touched": false,
                                "outlet": true,
                                "type": "number"
                              }
                            },
                            "inputs": [
                              {
                                "name": "voicebang",
                                "type": "bang",
                                "digest": "Bang to report the current voice number.",
                                "hot": true,
                                "docked": false
                              },
                              {
                                "name": "mute",
                                "type": [
                                  "bang",
                                  "number"
                                ],
                                "digest": "Bang or 1 to mute voice, 0 to unmute.",
                                "docked": false
                              }
                            ],
                            "outputs": [
                              {
                                "name": "voicenumber",
                                "type": "number",
                                "digest": "The current voice index.",
                                "docked": false
                              },
                              {
                                "name": "noteNumber",
                                "type": "number",
                                "digest": "The current note number.",
                                "docked": false
                              },
                              {
                                "name": "mutestatus",
                                "type": "number",
                                "digest": "The current voice status.",
                                "docked": false
                              },
                              {
                                "name": "activevoices",
                                "type": "number",
                                "digest": "The number of currently active voices.",
                                "docked": false
                              }
                            ],
                            "helpname": "voice",
                            "aliasOf": "voice",
                            "classname": "voice",
                            "operator": false,
                            "versionId": 0,
                            "changesPatcherIO": false
                          },
                          "rnbo_classname": "voice",
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
                      }
                    ],
                    "lines": [
                      {
                        "patchline": {
                          "source": [
                            "obj-5",
                            0
                          ],
                          "destination": [
                            "obj-6",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-5",
                            1
                          ],
                          "destination": [
                            "obj-8",
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
                            "obj-9",
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
                            "obj-10",
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
                            "obj-10",
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
                            "obj-11",
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
                            "obj-9",
                            1
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
                            "obj-9",
                            4
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
                            "obj-14",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-1",
                            0
                          ],
                          "destination": [
                            "obj-14",
                            1
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
                            "obj-6",
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
                            "obj-2",
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
                            "obj-17",
                            0
                          ],
                          "destination": [
                            "obj-16",
                            1
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
                            "obj-18",
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
                            "obj-18",
                            1
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
                            "obj-7",
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
                            "obj-11",
                            1
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-9",
                            1
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
                            "obj-11",
                            0
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
                            "obj-11",
                            0
                          ],
                          "destination": [
                            "obj-13",
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
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "target": {
                        "attrOrProp": 1,
                        "digest": "target",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "mute": {
                        "attrOrProp": 1,
                        "digest": "mute",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "list"
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
                      "out2": {
                        "attrOrProp": 1,
                        "digest": "out2",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "signal"
                      },
                      "midiin": {
                        "attrOrProp": 1,
                        "digest": "midiin",
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
                      "polyphony": {
                        "attrOrProp": 2,
                        "digest": "Polyphony of the subpatcher.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "-1"
                      },
                      "exposevoiceparams": {
                        "attrOrProp": 2,
                        "digest": "Expose per voice versions of the contained parameters (only valid in polyphonic subpatchers).",
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
                      "title": {
                        "attrOrProp": 2,
                        "digest": "Title of the subpatcher",
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
                      "file": {
                        "attrOrProp": 2,
                        "digest": "rnbo file to load",
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
                      "voicecontrol": {
                        "attrOrProp": 2,
                        "digest": "Chooses the way that polyphonic voices are controlled. 'simple' (or 'midi') will automatically allocate voices for \tincoming MIDI notes. Setting it to 'user' (or 'none') will switch off MIDI \tvoice allocation and start with all voices unmuted.",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "enum": [
                          "simple",
                          "user"
                        ],
                        "type": "enum",
                        "defaultValue": "simple"
                      },
                      "notecontroller": {
                        "attrOrProp": 2,
                        "digest": "DEPRECATED. Use voicecontrol instead.",
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
                      "receivemode": {
                        "attrOrProp": 2,
                        "digest": "Do receive~ objects get the signal from a send~ inside the patcher directly (without latency), or compensated (with latency, aligned with all other voices).",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "enum": [
                          "local",
                          "compensated"
                        ],
                        "type": "enum",
                        "defaultValue": "local"
                      },
                      "args": {
                        "attrOrProp": 2,
                        "digest": "Replacement args for the subpatcher, everything named #1, #2 etc. will be replaced with the according argument.",
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
                      "uidstyle": {
                        "attrOrProp": 2,
                        "digest": "Behavior of #0 unique ID. auto (default) means abstractions get a local UID, local: start a new local UID, parent: use the one from the parent patcher",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "enum": [
                          "auto",
                          "local",
                          "parent",
                          "global"
                        ],
                        "type": "enum",
                        "defaultValue": "auto"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": [
                          "bang",
                          "number",
                          "list"
                        ],
                        "digest": "in1",
                        "displayName": "",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": [
                          "bang",
                          "number",
                          "list"
                        ],
                        "digest": "in2",
                        "displayName": "",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in3",
                        "type": [
                          "bang",
                          "number",
                          "list"
                        ],
                        "digest": "in3",
                        "displayName": "",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in4",
                        "type": [
                          "bang",
                          "number",
                          "list"
                        ],
                        "digest": "in4",
                        "displayName": "",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in5",
                        "type": [
                          "bang",
                          "number",
                          "list"
                        ],
                        "digest": "in5",
                        "displayName": "",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "midiin",
                        "type": "number",
                        "digest": "midiin",
                        "hot": true,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "signal",
                        "digest": "out1",
                        "displayName": "",
                        "docked": false
                      },
                      {
                        "name": "out2",
                        "type": "signal",
                        "digest": "out2",
                        "displayName": "",
                        "docked": false
                      }
                    ],
                    "helpname": "patcher",
                    "aliasOf": "rnbo",
                    "classname": "p",
                    "operator": false,
                    "versionId": 426236520,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "p",
                  "numinlets": 6,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    "signal"
                  ],
                  "rnbo_extra_attributes": {
                    "title": "synth",
                    "polyphony": 4,
                    "voicecontrol": "midi"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-10",
                  "maxclass": "newobj",
                  "text": "midiin",
                  "patching_rect": [
                    800,
                    180,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "midi",
                  "rnbo_serial": 9,
                  "rnboinfo": {
                    "needsInstanceInfo": false,
                    "argnames": {
                      "port": {
                        "attrOrProp": 1,
                        "digest": "select port",
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
                      "midiout": {
                        "attrOrProp": 1,
                        "digest": "MIDI stream",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      }
                    },
                    "inputs": [
                      {
                        "name": "port",
                        "type": "number",
                        "digest": "select port",
                        "hot": true,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "midiout",
                        "type": "number",
                        "digest": "MIDI stream",
                        "docked": false
                      }
                    ],
                    "helpname": "midiin",
                    "aliasOf": "midiin",
                    "classname": "midiin",
                    "operator": false,
                    "versionId": 0,
                    "changesPatcherIO": true
                  },
                  "rnbo_classname": "midiin",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {}
                }
              },
              {
                "box": {
                  "id": "obj-11",
                  "maxclass": "newobj",
                  "text": "* 44.1",
                  "patching_rect": [
                    20,
                    270,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "time_samples",
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
                        "defaultValue": "44.1"
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
                    "in2": 44.1,
                    "serialclassname": "*",
                    "expr": "out1 = in1*in2",
                    "isConvertedOperator": true,
                    "cold": true
                  }
                }
              },
              {
                "box": {
                  "id": "obj-12",
                  "maxclass": "newobj",
                  "text": "delay~ 8192 5292 @ramp 20",
                  "patching_rect": [
                    300,
                    440,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "echo_delay",
                  "rnbo_serial": 11,
                  "rnboinfo": {
                    "needsInstanceInfo": false,
                    "argnames": {
                      "clear": {
                        "attrOrProp": 1,
                        "digest": "Clears the delay buffer.",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "input": {
                        "attrOrProp": 1,
                        "digest": "Signal to be delayed",
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
                      "delay": {
                        "attrOrProp": 1,
                        "digest": "Delay time (samples or any time unit)",
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
                      "output": {
                        "attrOrProp": 1,
                        "digest": "Delayed Output",
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
                      "ramp": {
                        "attrOrProp": 2,
                        "digest": "crossfade time between different delay times (ms)",
                        "defaultarg": 3,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "50"
                      },
                      "maxsize": {
                        "attrOrProp": 2,
                        "digest": "size of delay buffer (samples)",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "samplerate"
                      },
                      "maxdelayms": {
                        "attrOrProp": 2,
                        "digest": "size of delay buffer (ms)",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0"
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
                      }
                    },
                    "inputs": [
                      {
                        "name": "input",
                        "type": "signal",
                        "digest": "Signal to be delayed",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "delay",
                        "type": "auto",
                        "digest": "Delay time (samples or any time unit)",
                        "defaultarg": 2,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "output",
                        "type": "signal",
                        "digest": "Delayed Output",
                        "docked": false
                      }
                    ],
                    "helpname": "delay~",
                    "aliasOf": "delay~",
                    "classname": "delay~",
                    "operator": false,
                    "versionId": 0,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "delay~",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "rnbo_extra_attributes": {
                    "maxsize": 8192,
                    "delay": 5292,
                    "ramp": 20
                  }
                }
              },
              {
                "box": {
                  "id": "obj-13",
                  "maxclass": "newobj",
                  "text": "feedback~",
                  "patching_rect": [
                    600,
                    440,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "feedback_vec",
                  "rnbo_serial": 12,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "input": {
                        "attrOrProp": 1,
                        "digest": "Signal to feed back.",
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
                      "output": {
                        "attrOrProp": 1,
                        "digest": "Signal that was fed back (with a sample vector length delay).",
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
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Clears/resets the feedback buffer",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      }
                    },
                    "inputs": [
                      {
                        "name": "input",
                        "type": "signal",
                        "digest": "Signal to feed back.",
                        "hot": true,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "output",
                        "type": "signal",
                        "digest": "Signal that was fed back (with a sample vector length delay).",
                        "docked": false
                      }
                    ],
                    "helpname": "feedback~",
                    "aliasOf": "feedback~",
                    "classname": "feedback~",
                    "operator": false,
                    "versionId": -230049787,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "feedback~",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "rnbo_extra_attributes": {}
                }
              },
              {
                "box": {
                  "id": "obj-14",
                  "maxclass": "newobj",
                  "text": "*~",
                  "patching_rect": [
                    600,
                    380,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "feedback_gain",
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
                  "id": "obj-15",
                  "maxclass": "newobj",
                  "text": "expr 1. - in1",
                  "patching_rect": [
                    20,
                    320,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "feed_gain",
                  "rnbo_serial": 14,
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
                      1,
                      "-",
                      "in1"
                    ]
                  }
                }
              },
              {
                "box": {
                  "id": "obj-16",
                  "maxclass": "newobj",
                  "text": "*~",
                  "patching_rect": [
                    20,
                    380,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "input_gain",
                  "rnbo_serial": 15,
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
                  "id": "obj-17",
                  "maxclass": "newobj",
                  "text": "+~",
                  "patching_rect": [
                    300,
                    380,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "echo_input",
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
                    "serialclassname": "+~",
                    "expr": "out1 = in1+in2",
                    "isConvertedOperator": true,
                    "cold": true
                  }
                }
              },
              {
                "box": {
                  "id": "obj-18",
                  "maxclass": "newobj",
                  "text": "delay~ 256 128 @ramp 0",
                  "patching_rect": [
                    600,
                    500,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "stereo_offset",
                  "rnbo_serial": 17,
                  "rnboinfo": {
                    "needsInstanceInfo": false,
                    "argnames": {
                      "clear": {
                        "attrOrProp": 1,
                        "digest": "Clears the delay buffer.",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "input": {
                        "attrOrProp": 1,
                        "digest": "Signal to be delayed",
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
                      "delay": {
                        "attrOrProp": 1,
                        "digest": "Delay time (samples or any time unit)",
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
                      "output": {
                        "attrOrProp": 1,
                        "digest": "Delayed Output",
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
                      "ramp": {
                        "attrOrProp": 2,
                        "digest": "crossfade time between different delay times (ms)",
                        "defaultarg": 3,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "50"
                      },
                      "maxsize": {
                        "attrOrProp": 2,
                        "digest": "size of delay buffer (samples)",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "defaultValue": "samplerate"
                      },
                      "maxdelayms": {
                        "attrOrProp": 2,
                        "digest": "size of delay buffer (ms)",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "number",
                        "defaultValue": "0"
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
                      }
                    },
                    "inputs": [
                      {
                        "name": "input",
                        "type": "signal",
                        "digest": "Signal to be delayed",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "delay",
                        "type": "auto",
                        "digest": "Delay time (samples or any time unit)",
                        "defaultarg": 2,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "output",
                        "type": "signal",
                        "digest": "Delayed Output",
                        "docked": false
                      }
                    ],
                    "helpname": "delay~",
                    "aliasOf": "delay~",
                    "classname": "delay~",
                    "operator": false,
                    "versionId": 0,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "delay~",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "rnbo_extra_attributes": {
                    "maxsize": 256,
                    "delay": 128,
                    "ramp": 0
                  }
                }
              },
              {
                "box": {
                  "id": "obj-19",
                  "maxclass": "newobj",
                  "text": "expr 1. - in1",
                  "patching_rect": [
                    20,
                    500,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "dry_amount",
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
                      1,
                      "-",
                      "in1"
                    ]
                  }
                }
              },
              {
                "box": {
                  "id": "obj-20",
                  "maxclass": "newobj",
                  "text": "*~",
                  "patching_rect": [
                    20,
                    550,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "dry",
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
                  "id": "obj-21",
                  "maxclass": "newobj",
                  "text": "*~",
                  "patching_rect": [
                    300,
                    550,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "wet_l",
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
                  "id": "obj-22",
                  "maxclass": "newobj",
                  "text": "+~",
                  "patching_rect": [
                    300,
                    610,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "mix_l",
                  "rnbo_serial": 21,
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
                    "serialclassname": "+~",
                    "expr": "out1 = in1+in2",
                    "isConvertedOperator": true,
                    "cold": true
                  }
                }
              },
              {
                "box": {
                  "id": "obj-23",
                  "maxclass": "newobj",
                  "text": "out~ 1",
                  "patching_rect": [
                    300,
                    660,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "out_l",
                  "rnbo_serial": 22,
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
                  "id": "obj-24",
                  "maxclass": "newobj",
                  "text": "*~",
                  "patching_rect": [
                    600,
                    550,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "wet_r",
                  "rnbo_serial": 23,
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
                  "id": "obj-25",
                  "maxclass": "newobj",
                  "text": "+~",
                  "patching_rect": [
                    600,
                    610,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "mix_r",
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
                    "serialclassname": "+~",
                    "expr": "out1 = in1+in2",
                    "isConvertedOperator": true,
                    "cold": true
                  }
                }
              },
              {
                "box": {
                  "id": "obj-26",
                  "maxclass": "newobj",
                  "text": "out~ 2",
                  "patching_rect": [
                    600,
                    660,
                    240,
                    22
                  ],
                  "rnbo_uniqueid": "out_r",
                  "rnbo_serial": 25,
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
              },
              {
                "box": {
                  "id": "obj-27",
                  "text": "ctlin 120",
                  "maxclass": "newobj",
                  "patching_rect": [
                    800,
                    280,
                    150,
                    22
                  ],
                  "rnbo_uniqueid": "panic_cc",
                  "rnbo_serial": 26,
                  "rnboinfo": {
                    "needsInstanceInfo": false,
                    "argnames": {
                      "value": {
                        "attrOrProp": 1,
                        "digest": "control value (0-127)",
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
                      "outcontroller": {
                        "attrOrProp": 1,
                        "digest": "controller number (0-127)",
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
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number",
                        "defaultValue": "0"
                      },
                      "controller": {
                        "attrOrProp": 1,
                        "digest": "controller number to receive (-1 for all)",
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
                        "defaultValue": "-1"
                      },
                      "channel": {
                        "attrOrProp": 1,
                        "digest": "MIDI Channel to receive (-1 for all)",
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
                        "defaultValue": "-1"
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
                        "name": "controller",
                        "type": "number",
                        "digest": "controller number to receive (-1 for all)",
                        "defaultarg": 1,
                        "docked": false
                      },
                      {
                        "name": "channel",
                        "type": "number",
                        "digest": "MIDI Channel to receive (-1 for all)",
                        "defaultarg": 2,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "control value (0-127)",
                        "docked": false
                      },
                      {
                        "name": "outcontroller",
                        "type": "number",
                        "digest": "controller number (0-127)",
                        "docked": false
                      },
                      {
                        "name": "outchannel",
                        "type": "number",
                        "digest": "MIDI channel (1-16)",
                        "docked": false
                      }
                    ],
                    "helpname": "ctlin",
                    "aliasOf": "ctlin",
                    "classname": "ctlin",
                    "operator": false,
                    "versionId": 0,
                    "changesPatcherIO": true
                  },
                  "rnbo_classname": "ctlin",
                  "numinlets": 3,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "controller": 120
                  }
                }
              },
              {
                "box": {
                  "id": "obj-28",
                  "text": "t b",
                  "maxclass": "newobj",
                  "patching_rect": [
                    800,
                    330,
                    150,
                    22
                  ],
                  "rnbo_uniqueid": "panic_bang",
                  "rnbo_serial": 27,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "Output order 1 (bang).",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "bang"
                      },
                      "triggers": {
                        "attrOrProp": 2,
                        "digest": "The number of arguments determines the number of outlets. \t\t\t\t\t\tEach outlet sends out either a whole number, float, bang or list, \t\t\t\t\t\tas identified by symbol arguments (i, f, b, l). \t\t\t\t\t\tIf there are no arguments, there are two outlets, both of which send a float.",
                        "defaultarg": 1,
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
                        "name": "input",
                        "type": [
                          "bang",
                          "number",
                          "list"
                        ],
                        "digest": "input to distribute",
                        "hot": true,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "bang",
                        "digest": "Output order 1 (bang).",
                        "defaultarg": 1,
                        "docked": false
                      }
                    ],
                    "helpname": "trigger",
                    "aliasOf": "trigger",
                    "classname": "t",
                    "operator": false,
                    "versionId": 1624904035,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "t",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "triggers": "b"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-29",
                  "text": "set clear",
                  "maxclass": "newobj",
                  "patching_rect": [
                    800,
                    380,
                    150,
                    22
                  ],
                  "rnbo_uniqueid": "clear_echo",
                  "rnbo_serial": 28,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "name": {
                        "attrOrProp": 2,
                        "digest": "attribute/param to control",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "mandatory": true
                      }
                    },
                    "inputs": [
                      {
                        "name": "input",
                        "type": [
                          "bang",
                          "number",
                          "list",
                          "signal"
                        ],
                        "digest": "attribute or parameter value (bang, number, list)",
                        "hot": true,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "output",
                        "type": [
                          "bang",
                          "number",
                          "list",
                          "signal"
                        ],
                        "digest": "connect to first inlet of gen or subpatcher",
                        "docked": false
                      }
                    ],
                    "helpname": "set",
                    "aliasOf": "set",
                    "classname": "set",
                    "operator": false,
                    "versionId": 1197449671,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "set",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "name": "clear"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-30",
                  "text": "set reset",
                  "maxclass": "newobj",
                  "patching_rect": [
                    800,
                    430,
                    150,
                    22
                  ],
                  "rnbo_uniqueid": "reset_feedback",
                  "rnbo_serial": 29,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "name": {
                        "attrOrProp": 2,
                        "digest": "attribute/param to control",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "mandatory": true
                      }
                    },
                    "inputs": [
                      {
                        "name": "input",
                        "type": [
                          "bang",
                          "number",
                          "list",
                          "signal"
                        ],
                        "digest": "attribute or parameter value (bang, number, list)",
                        "hot": true,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "output",
                        "type": [
                          "bang",
                          "number",
                          "list",
                          "signal"
                        ],
                        "digest": "connect to first inlet of gen or subpatcher",
                        "docked": false
                      }
                    ],
                    "helpname": "set",
                    "aliasOf": "set",
                    "classname": "set",
                    "operator": false,
                    "versionId": 1197449671,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "set",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "name": "reset"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-31",
                  "text": "0 1",
                  "maxclass": "message",
                  "patching_rect": [
                    800,
                    480,
                    150,
                    22
                  ],
                  "rnbo_uniqueid": "mute_all",
                  "rnbo_serial": 30,
                  "rnboinfo": {
                    "needsInstanceInfo": false,
                    "argnames": {
                      "trigger": {
                        "attrOrProp": 1,
                        "digest": "trigger the message",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "bang"
                      },
                      "set": {
                        "attrOrProp": 1,
                        "digest": "set the message",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "list"
                      },
                      "listout": {
                        "attrOrProp": 1,
                        "digest": "listout",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "list"
                      },
                      "out": {
                        "attrOrProp": 1,
                        "digest": "Message out.",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "list"
                      },
                      "storeempty": {
                        "attrOrProp": 2,
                        "digest": "Store empty lists",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bool",
                        "defaultValue": "false",
                        "label": "Store Empty Lists"
                      },
                      "text": {
                        "attrOrProp": 2,
                        "digest": "text",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "list",
                        "defaultValue": ""
                      }
                    },
                    "inputs": [
                      {
                        "name": "trigger",
                        "type": "bang",
                        "digest": "trigger the message",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "set",
                        "type": "list",
                        "digest": "set the message",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out",
                        "type": "list",
                        "digest": "Message out.",
                        "docked": false
                      }
                    ],
                    "helpname": "message",
                    "aliasOf": "message",
                    "classname": "message",
                    "operator": false,
                    "versionId": 0,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "text": "",
                    "storeempty": 0
                  }
                }
              },
              {
                "box": {
                  "id": "obj-32",
                  "text": "set mute",
                  "maxclass": "newobj",
                  "patching_rect": [
                    800,
                    530,
                    150,
                    22
                  ],
                  "rnbo_uniqueid": "set_mute",
                  "rnbo_serial": 31,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "name": {
                        "attrOrProp": 2,
                        "digest": "attribute/param to control",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "mandatory": true
                      }
                    },
                    "inputs": [
                      {
                        "name": "input",
                        "type": [
                          "bang",
                          "number",
                          "list",
                          "signal"
                        ],
                        "digest": "attribute or parameter value (bang, number, list)",
                        "hot": true,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "output",
                        "type": [
                          "bang",
                          "number",
                          "list",
                          "signal"
                        ],
                        "digest": "connect to first inlet of gen or subpatcher",
                        "docked": false
                      }
                    ],
                    "helpname": "set",
                    "aliasOf": "set",
                    "classname": "set",
                    "operator": false,
                    "versionId": 1197449671,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "set",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "name": "mute"
                  }
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
                    "obj-9",
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
                    "obj-9",
                    1
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
                    "obj-9",
                    2
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
                    "obj-9",
                    3
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
                    "obj-9",
                    4
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
                    "obj-11",
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
                    "obj-14",
                    1
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
                    "obj-14",
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
                    "obj-15",
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
                    "obj-16",
                    0
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
                    1
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
                    "obj-14",
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
                    "obj-12",
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
                    "obj-12",
                    1
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
                    "obj-12",
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
                    "obj-8",
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
                    "obj-9",
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
                    "obj-12",
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
                    "obj-8",
                    0
                  ],
                  "destination": [
                    "obj-21",
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
                    "obj-22",
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
                    "obj-18",
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
                    "obj-8",
                    0
                  ],
                  "destination": [
                    "obj-24",
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
                    "obj-25",
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
                    "obj-25",
                    1
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
                    "obj-26",
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
                    "obj-9",
                    5
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
                    "obj-28",
                    0
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
                    "obj-29",
                    0
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
                    "obj-29",
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
                    "obj-28",
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
                    "obj-30",
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
                    "obj-28",
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
                    "obj-32",
                    0
                  ],
                  "destination": [
                    "obj-9",
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
          "text": "level 0.075",
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
          "text": "ratio 2",
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
          "text": "depth 1.5",
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
          "text": "echo_time 120",
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
          "text": "echo_feedback 0.45",
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
          "text": "echo_mix 0.28",
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
          "text": "attack 10",
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
          "text": "release 150",
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
