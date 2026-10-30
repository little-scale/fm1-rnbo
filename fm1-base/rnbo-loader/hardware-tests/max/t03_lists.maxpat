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
                  "text": "Sixty Four Step List — Hold a note and scan Step through the stored melody. First changes the last step after reversal. Transpose shifts the whole melody.",
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
                  "text": "param step 0 @min 0 @max 63 @displayorder 2 @displayname \"Step\"",
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
                    "name": "step",
                    "value": 0,
                    "min": 0,
                    "max": 63,
                    "displayorder": 2,
                    "displayname": "Step"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-4",
                  "text": "param first 0 @min -12 @max 12 @displayorder 3 @displayname \"First\"",
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
                    "name": "first",
                    "value": 0,
                    "min": -12,
                    "max": 12,
                    "displayorder": 3,
                    "displayname": "First"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-5",
                  "text": "param transpose 0 @min -12 @max 12 @displayorder 4 @displayname \"Transpose\"",
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
                    "name": "transpose",
                    "value": 0,
                    "min": -12,
                    "max": 12,
                    "displayorder": 4,
                    "displayname": "Transpose"
                  }
                }
              },
              {
                "box": {
                  "id": "obj-6",
                  "text": "param brightness 2000 @min 100 @max 8000 @displayorder 5 @displayname \"Brightness\"",
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
                    "name": "brightness",
                    "value": 2000,
                    "min": 100,
                    "max": 8000,
                    "displayorder": 5,
                    "displayname": "Brightness"
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
                  "text": "pack 0. 2. 4. 7. 9. 7. 4. 2. 0. 2. 4. 7. 9. 7. 4. 2. 0. 2. 4. 7. 9. 7. 4. 2. 0. 2. 4. 7. 9. 7. 4. 2. 0. 2. 4. 7. 9. 7. 4. 2. 0. 2. 4. 7. 9. 7. 4. 2. 0. 2. 4. 7. 9. 7. 4. 2. 0. 2. 4. 7. 9. 7. 4. 2.",
                  "patching_rect": [
                    305,
                    228,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "pack_obj-14",
                  "rnbo_serial": 13,
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
                      "in3": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 3",
                        "defaultarg": 3,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in4": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 4",
                        "defaultarg": 4,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in5": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 5",
                        "defaultarg": 5,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in6": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 6",
                        "defaultarg": 6,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in7": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 7",
                        "defaultarg": 7,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in8": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 8",
                        "defaultarg": 8,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in9": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 9",
                        "defaultarg": 9,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in10": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 10",
                        "defaultarg": 10,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in11": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 11",
                        "defaultarg": 11,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in12": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 12",
                        "defaultarg": 12,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in13": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 13",
                        "defaultarg": 13,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in14": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 14",
                        "defaultarg": 14,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in15": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 15",
                        "defaultarg": 15,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in16": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 16",
                        "defaultarg": 16,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in17": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 17",
                        "defaultarg": 17,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in18": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 18",
                        "defaultarg": 18,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in19": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 19",
                        "defaultarg": 19,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in20": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 20",
                        "defaultarg": 20,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in21": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 21",
                        "defaultarg": 21,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in22": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 22",
                        "defaultarg": 22,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in23": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 23",
                        "defaultarg": 23,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in24": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 24",
                        "defaultarg": 24,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in25": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 25",
                        "defaultarg": 25,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in26": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 26",
                        "defaultarg": 26,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in27": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 27",
                        "defaultarg": 27,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in28": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 28",
                        "defaultarg": 28,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in29": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 29",
                        "defaultarg": 29,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in30": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 30",
                        "defaultarg": 30,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in31": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 31",
                        "defaultarg": 31,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in32": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 32",
                        "defaultarg": 32,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in33": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 33",
                        "defaultarg": 33,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in34": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 34",
                        "defaultarg": 34,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in35": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 35",
                        "defaultarg": 35,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in36": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 36",
                        "defaultarg": 36,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in37": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 37",
                        "defaultarg": 37,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in38": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 38",
                        "defaultarg": 38,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in39": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 39",
                        "defaultarg": 39,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in40": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 40",
                        "defaultarg": 40,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in41": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 41",
                        "defaultarg": 41,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in42": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 42",
                        "defaultarg": 42,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in43": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 43",
                        "defaultarg": 43,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in44": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 44",
                        "defaultarg": 44,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in45": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 45",
                        "defaultarg": 45,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in46": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 46",
                        "defaultarg": 46,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in47": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 47",
                        "defaultarg": 47,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in48": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 48",
                        "defaultarg": 48,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in49": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 49",
                        "defaultarg": 49,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in50": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 50",
                        "defaultarg": 50,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in51": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 51",
                        "defaultarg": 51,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in52": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 52",
                        "defaultarg": 52,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in53": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 53",
                        "defaultarg": 53,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in54": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 54",
                        "defaultarg": 54,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in55": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 55",
                        "defaultarg": 55,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in56": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 56",
                        "defaultarg": 56,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in57": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 57",
                        "defaultarg": 57,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in58": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 58",
                        "defaultarg": 58,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in59": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 59",
                        "defaultarg": 59,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in60": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 60",
                        "defaultarg": 60,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in61": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 61",
                        "defaultarg": 61,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in62": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 62",
                        "defaultarg": 62,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in63": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 63",
                        "defaultarg": 63,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "number"
                      },
                      "in64": {
                        "attrOrProp": 1,
                        "digest": "number to be list element 64",
                        "defaultarg": 64,
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
                      },
                      {
                        "name": "in3",
                        "type": "number",
                        "digest": "number to be list element 3",
                        "defaultarg": 3,
                        "docked": false
                      },
                      {
                        "name": "in4",
                        "type": "number",
                        "digest": "number to be list element 4",
                        "defaultarg": 4,
                        "docked": false
                      },
                      {
                        "name": "in5",
                        "type": "number",
                        "digest": "number to be list element 5",
                        "defaultarg": 5,
                        "docked": false
                      },
                      {
                        "name": "in6",
                        "type": "number",
                        "digest": "number to be list element 6",
                        "defaultarg": 6,
                        "docked": false
                      },
                      {
                        "name": "in7",
                        "type": "number",
                        "digest": "number to be list element 7",
                        "defaultarg": 7,
                        "docked": false
                      },
                      {
                        "name": "in8",
                        "type": "number",
                        "digest": "number to be list element 8",
                        "defaultarg": 8,
                        "docked": false
                      },
                      {
                        "name": "in9",
                        "type": "number",
                        "digest": "number to be list element 9",
                        "defaultarg": 9,
                        "docked": false
                      },
                      {
                        "name": "in10",
                        "type": "number",
                        "digest": "number to be list element 10",
                        "defaultarg": 10,
                        "docked": false
                      },
                      {
                        "name": "in11",
                        "type": "number",
                        "digest": "number to be list element 11",
                        "defaultarg": 11,
                        "docked": false
                      },
                      {
                        "name": "in12",
                        "type": "number",
                        "digest": "number to be list element 12",
                        "defaultarg": 12,
                        "docked": false
                      },
                      {
                        "name": "in13",
                        "type": "number",
                        "digest": "number to be list element 13",
                        "defaultarg": 13,
                        "docked": false
                      },
                      {
                        "name": "in14",
                        "type": "number",
                        "digest": "number to be list element 14",
                        "defaultarg": 14,
                        "docked": false
                      },
                      {
                        "name": "in15",
                        "type": "number",
                        "digest": "number to be list element 15",
                        "defaultarg": 15,
                        "docked": false
                      },
                      {
                        "name": "in16",
                        "type": "number",
                        "digest": "number to be list element 16",
                        "defaultarg": 16,
                        "docked": false
                      },
                      {
                        "name": "in17",
                        "type": "number",
                        "digest": "number to be list element 17",
                        "defaultarg": 17,
                        "docked": false
                      },
                      {
                        "name": "in18",
                        "type": "number",
                        "digest": "number to be list element 18",
                        "defaultarg": 18,
                        "docked": false
                      },
                      {
                        "name": "in19",
                        "type": "number",
                        "digest": "number to be list element 19",
                        "defaultarg": 19,
                        "docked": false
                      },
                      {
                        "name": "in20",
                        "type": "number",
                        "digest": "number to be list element 20",
                        "defaultarg": 20,
                        "docked": false
                      },
                      {
                        "name": "in21",
                        "type": "number",
                        "digest": "number to be list element 21",
                        "defaultarg": 21,
                        "docked": false
                      },
                      {
                        "name": "in22",
                        "type": "number",
                        "digest": "number to be list element 22",
                        "defaultarg": 22,
                        "docked": false
                      },
                      {
                        "name": "in23",
                        "type": "number",
                        "digest": "number to be list element 23",
                        "defaultarg": 23,
                        "docked": false
                      },
                      {
                        "name": "in24",
                        "type": "number",
                        "digest": "number to be list element 24",
                        "defaultarg": 24,
                        "docked": false
                      },
                      {
                        "name": "in25",
                        "type": "number",
                        "digest": "number to be list element 25",
                        "defaultarg": 25,
                        "docked": false
                      },
                      {
                        "name": "in26",
                        "type": "number",
                        "digest": "number to be list element 26",
                        "defaultarg": 26,
                        "docked": false
                      },
                      {
                        "name": "in27",
                        "type": "number",
                        "digest": "number to be list element 27",
                        "defaultarg": 27,
                        "docked": false
                      },
                      {
                        "name": "in28",
                        "type": "number",
                        "digest": "number to be list element 28",
                        "defaultarg": 28,
                        "docked": false
                      },
                      {
                        "name": "in29",
                        "type": "number",
                        "digest": "number to be list element 29",
                        "defaultarg": 29,
                        "docked": false
                      },
                      {
                        "name": "in30",
                        "type": "number",
                        "digest": "number to be list element 30",
                        "defaultarg": 30,
                        "docked": false
                      },
                      {
                        "name": "in31",
                        "type": "number",
                        "digest": "number to be list element 31",
                        "defaultarg": 31,
                        "docked": false
                      },
                      {
                        "name": "in32",
                        "type": "number",
                        "digest": "number to be list element 32",
                        "defaultarg": 32,
                        "docked": false
                      },
                      {
                        "name": "in33",
                        "type": "number",
                        "digest": "number to be list element 33",
                        "defaultarg": 33,
                        "docked": false
                      },
                      {
                        "name": "in34",
                        "type": "number",
                        "digest": "number to be list element 34",
                        "defaultarg": 34,
                        "docked": false
                      },
                      {
                        "name": "in35",
                        "type": "number",
                        "digest": "number to be list element 35",
                        "defaultarg": 35,
                        "docked": false
                      },
                      {
                        "name": "in36",
                        "type": "number",
                        "digest": "number to be list element 36",
                        "defaultarg": 36,
                        "docked": false
                      },
                      {
                        "name": "in37",
                        "type": "number",
                        "digest": "number to be list element 37",
                        "defaultarg": 37,
                        "docked": false
                      },
                      {
                        "name": "in38",
                        "type": "number",
                        "digest": "number to be list element 38",
                        "defaultarg": 38,
                        "docked": false
                      },
                      {
                        "name": "in39",
                        "type": "number",
                        "digest": "number to be list element 39",
                        "defaultarg": 39,
                        "docked": false
                      },
                      {
                        "name": "in40",
                        "type": "number",
                        "digest": "number to be list element 40",
                        "defaultarg": 40,
                        "docked": false
                      },
                      {
                        "name": "in41",
                        "type": "number",
                        "digest": "number to be list element 41",
                        "defaultarg": 41,
                        "docked": false
                      },
                      {
                        "name": "in42",
                        "type": "number",
                        "digest": "number to be list element 42",
                        "defaultarg": 42,
                        "docked": false
                      },
                      {
                        "name": "in43",
                        "type": "number",
                        "digest": "number to be list element 43",
                        "defaultarg": 43,
                        "docked": false
                      },
                      {
                        "name": "in44",
                        "type": "number",
                        "digest": "number to be list element 44",
                        "defaultarg": 44,
                        "docked": false
                      },
                      {
                        "name": "in45",
                        "type": "number",
                        "digest": "number to be list element 45",
                        "defaultarg": 45,
                        "docked": false
                      },
                      {
                        "name": "in46",
                        "type": "number",
                        "digest": "number to be list element 46",
                        "defaultarg": 46,
                        "docked": false
                      },
                      {
                        "name": "in47",
                        "type": "number",
                        "digest": "number to be list element 47",
                        "defaultarg": 47,
                        "docked": false
                      },
                      {
                        "name": "in48",
                        "type": "number",
                        "digest": "number to be list element 48",
                        "defaultarg": 48,
                        "docked": false
                      },
                      {
                        "name": "in49",
                        "type": "number",
                        "digest": "number to be list element 49",
                        "defaultarg": 49,
                        "docked": false
                      },
                      {
                        "name": "in50",
                        "type": "number",
                        "digest": "number to be list element 50",
                        "defaultarg": 50,
                        "docked": false
                      },
                      {
                        "name": "in51",
                        "type": "number",
                        "digest": "number to be list element 51",
                        "defaultarg": 51,
                        "docked": false
                      },
                      {
                        "name": "in52",
                        "type": "number",
                        "digest": "number to be list element 52",
                        "defaultarg": 52,
                        "docked": false
                      },
                      {
                        "name": "in53",
                        "type": "number",
                        "digest": "number to be list element 53",
                        "defaultarg": 53,
                        "docked": false
                      },
                      {
                        "name": "in54",
                        "type": "number",
                        "digest": "number to be list element 54",
                        "defaultarg": 54,
                        "docked": false
                      },
                      {
                        "name": "in55",
                        "type": "number",
                        "digest": "number to be list element 55",
                        "defaultarg": 55,
                        "docked": false
                      },
                      {
                        "name": "in56",
                        "type": "number",
                        "digest": "number to be list element 56",
                        "defaultarg": 56,
                        "docked": false
                      },
                      {
                        "name": "in57",
                        "type": "number",
                        "digest": "number to be list element 57",
                        "defaultarg": 57,
                        "docked": false
                      },
                      {
                        "name": "in58",
                        "type": "number",
                        "digest": "number to be list element 58",
                        "defaultarg": 58,
                        "docked": false
                      },
                      {
                        "name": "in59",
                        "type": "number",
                        "digest": "number to be list element 59",
                        "defaultarg": 59,
                        "docked": false
                      },
                      {
                        "name": "in60",
                        "type": "number",
                        "digest": "number to be list element 60",
                        "defaultarg": 60,
                        "docked": false
                      },
                      {
                        "name": "in61",
                        "type": "number",
                        "digest": "number to be list element 61",
                        "defaultarg": 61,
                        "docked": false
                      },
                      {
                        "name": "in62",
                        "type": "number",
                        "digest": "number to be list element 62",
                        "defaultarg": 62,
                        "docked": false
                      },
                      {
                        "name": "in63",
                        "type": "number",
                        "digest": "number to be list element 63",
                        "defaultarg": 63,
                        "docked": false
                      },
                      {
                        "name": "in64",
                        "type": "number",
                        "digest": "number to be list element 64",
                        "defaultarg": 64,
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
                  "numinlets": 64,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {}
                }
              },
              {
                "box": {
                  "id": "obj-15",
                  "text": "list.reg",
                  "patching_rect": [
                    585,
                    228,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "list.reg_obj-15",
                  "rnbo_serial": 14,
                  "rnboinfo": {
                    "needsInstanceInfo": false,
                    "argnames": {
                      "in1": {
                        "attrOrProp": 1,
                        "digest": "Bang to output or list to store and output immediately",
                        "defaultarg": 1,
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
                      "in2": {
                        "attrOrProp": 1,
                        "digest": "List to store",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "list",
                        "defaultValue": ""
                      },
                      "out": {
                        "attrOrProp": 1,
                        "digest": "Stored list",
                        "isalias": false,
                        "aliases": [],
                        "settable": false,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "list"
                      },
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "reset",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
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
                        "defaultValue": "false",
                        "label": "Include In Preset",
                        "category": "Preset"
                      },
                      "order": {
                        "attrOrProp": 2,
                        "digest": "Preset restore order (a number, 'first' or 'last').",
                        "isalias": false,
                        "aliases": [],
                        "settable": true,
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "symbol",
                        "label": "Restore Order",
                        "category": "Preset"
                      }
                    },
                    "inputs": [
                      {
                        "name": "in1",
                        "type": [
                          "list",
                          "bang"
                        ],
                        "digest": "Bang to output or list to store and output immediately",
                        "defaultarg": 1,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "in2",
                        "type": "list",
                        "digest": "List to store",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out",
                        "type": "list",
                        "digest": "Stored list",
                        "docked": false
                      }
                    ],
                    "helpname": "list.reg",
                    "aliasOf": "list.reg",
                    "classname": "list.reg",
                    "operator": false,
                    "versionId": 0,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "list.reg",
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
                  "id": "obj-16",
                  "text": "list.rev",
                  "patching_rect": [
                    865,
                    228,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "list.rev_obj-16",
                  "rnbo_serial": 15,
                  "rnboinfo": {
                    "needsInstanceInfo": false,
                    "argnames": {
                      "input": {
                        "attrOrProp": 1,
                        "digest": "List to reverse.",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "list"
                      },
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "reset",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "out": {
                        "attrOrProp": 1,
                        "digest": "Input list in reverse order.",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "list"
                      }
                    },
                    "inputs": [
                      {
                        "name": "input",
                        "type": [
                          "bang",
                          "list"
                        ],
                        "digest": "List to reverse.",
                        "hot": true,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out",
                        "type": "list",
                        "digest": "Input list in reverse order.",
                        "docked": false
                      }
                    ],
                    "helpname": "list.rev",
                    "aliasOf": "list.rev",
                    "classname": "list.rev",
                    "operator": false,
                    "versionId": 0,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "list.rev",
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
                  "id": "obj-17",
                  "text": "int",
                  "patching_rect": [
                    25,
                    294,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "int_obj-17",
                  "rnbo_serial": 16,
                  "rnboinfo": {
                    "needsInstanceInfo": false,
                    "argnames": {
                      "input": {
                        "attrOrProp": 1,
                        "digest": "Bang outputs value, number sets and outputs value",
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
                      "value": {
                        "attrOrProp": 1,
                        "digest": "Set value without output",
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
                      "out": {
                        "attrOrProp": 1,
                        "digest": "Stored number",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "number"
                      },
                      "initial": {
                        "attrOrProp": 2,
                        "digest": "Initial value",
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
                        "name": "input",
                        "type": [
                          "bang",
                          "number"
                        ],
                        "digest": "Bang outputs value, number sets and outputs value",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "value",
                        "type": "number",
                        "digest": "Set value without output",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out",
                        "type": "number",
                        "digest": "Stored number",
                        "docked": false
                      }
                    ],
                    "helpname": "int",
                    "aliasOf": "intnum",
                    "classname": "int",
                    "operator": false,
                    "versionId": 0,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "int",
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
                  "id": "obj-18",
                  "text": "t b l",
                  "patching_rect": [
                    305,
                    294,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "t_obj-18",
                  "rnbo_serial": 17,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "Output order 2 (bang).",
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
                      "out2": {
                        "attrOrProp": 1,
                        "digest": "Output order 1 (list).",
                        "defaultarg": 2,
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "list"
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
                        "digest": "Output order 2 (bang).",
                        "defaultarg": 1,
                        "docked": false
                      },
                      {
                        "name": "out2",
                        "type": "list",
                        "digest": "Output order 1 (list).",
                        "defaultarg": 2,
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
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "triggers": [
                      "b",
                      "l"
                    ]
                  }
                }
              },
              {
                "box": {
                  "id": "obj-19",
                  "text": "list.lookup",
                  "patching_rect": [
                    585,
                    294,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "list.lookup_obj-19",
                  "rnbo_serial": 18,
                  "rnboinfo": {
                    "needsInstanceInfo": false,
                    "argnames": {
                      "input": {
                        "attrOrProp": 1,
                        "digest": "position(s) to look for",
                        "isalias": false,
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
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "reset",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang"
                      },
                      "lookup": {
                        "attrOrProp": 1,
                        "digest": "list from which to extract the element(s)",
                        "defaultarg": 1,
                        "isalias": false,
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
                      "out": {
                        "attrOrProp": 1,
                        "digest": "extracted items",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "outlet": true,
                        "type": "list"
                      }
                    },
                    "inputs": [
                      {
                        "name": "input",
                        "type": "list",
                        "digest": "position(s) to look for",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "lookup",
                        "type": "list",
                        "digest": "list from which to extract the element(s)",
                        "defaultarg": 1,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out",
                        "type": "list",
                        "digest": "extracted items",
                        "docked": false
                      }
                    ],
                    "helpname": "list.lookup",
                    "aliasOf": "list.lookup",
                    "classname": "list.lookup",
                    "operator": false,
                    "versionId": 0,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "list.lookup",
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
                  "id": "obj-20",
                  "text": "unpack 0.",
                  "patching_rect": [
                    865,
                    294,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "unpack_obj-20",
                  "rnbo_serial": 19,
                  "rnboinfo": {
                    "needsInstanceInfo": true,
                    "argnames": {
                      "input": {
                        "attrOrProp": 1,
                        "digest": "input list",
                        "isalias": false,
                        "aliases": [],
                        "attachable": false,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "inlet": true,
                        "type": "list"
                      },
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "list element 1",
                        "defaultarg": 1,
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
                      "length": {
                        "attrOrProp": 2,
                        "digest": "how many things to unpack",
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
                        "digest": "the list to initialize the unpack object with",
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
                          "list"
                        ],
                        "digest": "input list",
                        "hot": true,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "number",
                        "digest": "list element 1",
                        "defaultarg": 1,
                        "docked": false
                      }
                    ],
                    "helpname": "unpack",
                    "aliasOf": "unpack",
                    "classname": "unpack",
                    "operator": false,
                    "versionId": 2023587622,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "unpack",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "rnbo_extra_attributes": {
                    "list": 0
                  }
                }
              },
              {
                "box": {
                  "id": "obj-21",
                  "text": "+ @hot 1",
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
                  "id": "obj-22",
                  "text": "+ @hot 1",
                  "patching_rect": [
                    305,
                    360,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr_obj-22",
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
                  "id": "obj-23",
                  "text": "expr 440. * exp((in1 - 69.) * 0.0577622650466621)",
                  "patching_rect": [
                    585,
                    360,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr_obj-23",
                  "rnbo_serial": 22,
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
                  "id": "obj-24",
                  "text": "saw~",
                  "patching_rect": [
                    865,
                    360,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "saw~_obj-24",
                  "rnbo_serial": 23,
                  "rnboinfo": {
                    "needsInstanceInfo": false,
                    "argnames": {
                      "out1": {
                        "attrOrProp": 1,
                        "digest": "Out",
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
                        "digest": "Frequency (Hz)",
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
                      "syncPhase": {
                        "attrOrProp": 1,
                        "digest": "Sync phasor",
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
                      "reset": {
                        "attrOrProp": 1,
                        "digest": "Banging this attribute will reset the object to its default state.",
                        "isalias": false,
                        "aliases": [],
                        "attachable": true,
                        "isparam": false,
                        "deprecated": false,
                        "touched": false,
                        "type": "bang",
                        "defaultValue": "0"
                      }
                    },
                    "inputs": [
                      {
                        "name": "frequency",
                        "type": "auto",
                        "digest": "Frequency (Hz)",
                        "displayName": "frequency",
                        "defaultarg": 1,
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "syncPhase",
                        "type": "auto",
                        "digest": "Sync phasor",
                        "displayName": "syncPhase",
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out1",
                        "type": "signal",
                        "digest": "Out",
                        "docked": false
                      },
                      {
                        "name": "out2",
                        "type": "signal",
                        "digest": "Phase",
                        "docked": false
                      }
                    ],
                    "helpname": "saw~",
                    "aliasOf": "saw~",
                    "classname": "saw~",
                    "operator": false,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "saw~",
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
                  "text": "lores~ 2000 0.1",
                  "patching_rect": [
                    25,
                    426,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "lores~_obj-25",
                  "rnbo_serial": 24,
                  "rnboinfo": {
                    "needsInstanceInfo": false,
                    "argnames": {
                      "input": {
                        "attrOrProp": 1,
                        "digest": "Input",
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
                      "out": {
                        "attrOrProp": 1,
                        "digest": "Filtered output",
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
                      "cutoff": {
                        "attrOrProp": 1,
                        "digest": "Cutoff Frequency",
                        "defaultarg": 1,
                        "isalias": false,
                        "aliases": [
                          "frequency"
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
                      "frequency": {
                        "attrOrProp": 1,
                        "digest": "Cutoff Frequency",
                        "defaultarg": 1,
                        "isalias": true,
                        "aliasOf": "cutoff",
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
                      "resonance": {
                        "attrOrProp": 1,
                        "digest": "Resonance (0. - 1.)",
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
                      "clear": {
                        "attrOrProp": 1,
                        "digest": "Clear",
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
                        "digest": "Input",
                        "hot": true,
                        "docked": false
                      },
                      {
                        "name": "cutoff",
                        "type": "auto",
                        "digest": "Cutoff Frequency",
                        "defaultarg": 1,
                        "docked": false
                      },
                      {
                        "name": "resonance",
                        "type": "auto",
                        "digest": "Resonance (0. - 1.)",
                        "defaultarg": 2,
                        "docked": false
                      }
                    ],
                    "outputs": [
                      {
                        "name": "out",
                        "type": "signal",
                        "digest": "Filtered output",
                        "docked": false
                      }
                    ],
                    "helpname": "lores~",
                    "aliasOf": "lores~",
                    "classname": "lores~",
                    "operator": false,
                    "versionId": 0,
                    "changesPatcherIO": false
                  },
                  "rnbo_classname": "lores~",
                  "numinlets": 3,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "rnbo_extra_attributes": {
                    "frequency": 2000,
                    "resonance": 0.1
                  }
                }
              },
              {
                "box": {
                  "id": "obj-26",
                  "text": "expr 2. * min(1. - in1, 0.5)",
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
                  "id": "obj-27",
                  "text": "expr 2. * min(in1, 0.5)",
                  "patching_rect": [
                    585,
                    426,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr_obj-27",
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
                  "text": "*~",
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
                  "id": "obj-32",
                  "text": "clip~ -0.8 0.8",
                  "patching_rect": [
                    865,
                    492,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr~_obj-32",
                  "rnbo_serial": 31,
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
                  "id": "obj-33",
                  "text": "out~ 1",
                  "patching_rect": [
                    25,
                    558,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "out~_obj-33",
                  "rnbo_serial": 32,
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
                  "text": "*~",
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
                  "id": "obj-36",
                  "text": "clip~ -0.8 0.8",
                  "patching_rect": [
                    865,
                    558,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "expr~_obj-36",
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
                  "id": "obj-37",
                  "text": "out~ 2",
                  "patching_rect": [
                    25,
                    624,
                    250,
                    22
                  ],
                  "maxclass": "newobj",
                  "rnbo_uniqueid": "out~_obj-37",
                  "rnbo_serial": 36,
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
                    "obj-4",
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
                    "obj-3",
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
                    "obj-17",
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
                    "obj-18",
                    1
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
                    "obj-18",
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
                    "obj-19",
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
                    "obj-5",
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
                    "obj-10",
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
                    "obj-24",
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
                    "obj-6",
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
                    "obj-7",
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
                    "obj-25",
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
                    "obj-27",
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
                    "obj-25",
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
                    "obj-26",
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
                    "obj-13",
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
                    "obj-2",
                    0
                  ],
                  "destination": [
                    "obj-31",
                    1
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
                    "obj-33",
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
                    "obj-34",
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
                    "obj-2",
                    0
                  ],
                  "destination": [
                    "obj-35",
                    1
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
              },
              {
                "patchline": {
                  "source": [
                    "obj-36",
                    0
                  ],
                  "destination": [
                    "obj-37",
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
          "text": "step 0",
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
          "text": "first 0",
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
          "text": "transpose 0",
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
          "text": "brightness 2000",
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
