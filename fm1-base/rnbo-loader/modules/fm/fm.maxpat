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
                  "text": "param ratio 2 @min 0.25 @max 8",
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
                    "max": 8
                  }
                }
              },
              {
                "box": {
                  "id": "obj-2",
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
                  "id": "obj-3",
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
                  "id": "obj-4",
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
                  "id": "obj-5",
                  "maxclass": "newobj",
                  "text": "*~",
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
                  "id": "obj-6",
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
                  "id": "obj-7",
                  "maxclass": "newobj",
                  "text": "param attack 10 @min 1 @max 1000",
                  "rnbo_classname": "param",
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
                    "max": 1000
                  }
                }
              },
              {
                "box": {
                  "id": "obj-8",
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
                  "id": "obj-11",
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
                  "id": "obj-12",
                  "maxclass": "newobj",
                  "text": "*~",
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
                  "id": "obj-13",
                  "maxclass": "newobj",
                  "text": "param depth 1.5 @min 0 @max 8",
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
                    "max": 8
                  }
                }
              },
              {
                "box": {
                  "id": "obj-14",
                  "maxclass": "newobj",
                  "text": "param release 150 @min 1 @max 2000",
                  "rnbo_classname": "param",
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
                    "max": 2000
                  }
                }
              },
              {
                "box": {
                  "id": "obj-15",
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
                  "id": "obj-16",
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
                  "id": "obj-17",
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
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "obj-2",
                    0
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
                    "obj-2",
                    1
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
                    "obj-3",
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
                    "obj-9",
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
                    "obj-10",
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
                    "obj-17",
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
                    "obj-4",
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
                    "obj-9",
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
                    "obj-9",
                    4
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
                    "obj-5",
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
                    "obj-5",
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
                    "obj-6",
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
                    "obj-12",
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
                    "obj-12",
                    1
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
                    "obj-12",
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
                    "obj-11",
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
                    "obj-15",
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
          "text": "ratio 2",
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
          "text": "attack 10",
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
          "text": "release 150",
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
      }
    ],
    "classnamespace": "box",
    "default_fontname": "Arial",
    "default_fontsize": 12
  }
}
