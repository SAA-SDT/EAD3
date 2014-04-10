[
  {
    "op": "core/column-removal",
    "description": "Remove column element",
    "columnName": "element"
  },
  {
    "op": "core/row-star",
    "description": "Star rows",
    "engineConfig": {
      "facets": [
        {
          "invert": false,
          "expression": "value",
          "selectError": false,
          "omitError": false,
          "selectBlank": true,
          "name": "element - elementName",
          "omitBlank": false,
          "columnName": "element - elementName",
          "type": "list",
          "selection": []
        }
      ],
      "mode": "row-based"
    },
    "starred": true
  },
  {
    "op": "core/row-removal",
    "description": "Remove rows",
    "engineConfig": {
      "facets": [
        {
          "invert": false,
          "expression": "value",
          "selectError": false,
          "omitError": false,
          "selectBlank": true,
          "name": "element - elementName",
          "omitBlank": false,
          "columnName": "element - elementName",
          "type": "list",
          "selection": []
        }
      ],
      "mode": "row-based"
    }
  },
  {
    "op": "core/column-move",
    "description": "Move column element - mayContain to position 2",
    "columnName": "element - mayContain",
    "index": 2
  },
  {
    "op": "core/column-addition",
    "description": "Create column attributes at index 2 based on column element - attributes using expression grel:join(sort(split(value, '|')), ',')",
    "engineConfig": {
      "facets": [],
      "mode": "record-based"
    },
    "newColumnName": "attributes",
    "columnInsertIndex": 2,
    "baseColumnName": "element - attributes",
    "expression": "grel:join(sort(split(value, '|')), ',')",
    "onError": "set-to-blank"
  },
  {
    "op": "core/column-addition",
    "description": "Create column elements at index 4 based on column element - mayContain using expression grel:join(sort(split(value, '|')), ',')",
    "engineConfig": {
      "facets": [],
      "mode": "record-based"
    },
    "newColumnName": "elements",
    "columnInsertIndex": 4,
    "baseColumnName": "element - mayContain",
    "expression": "grel:join(sort(split(value, '|')), ',')",
    "onError": "set-to-blank"
  },
  {
    "op": "core/column-removal",
    "description": "Remove column element - attributes",
    "columnName": "element - attributes"
  },
  {
    "op": "core/column-removal",
    "description": "Remove column element - mayContain",
    "columnName": "element - mayContain"
  },
  {
    "op": "core/column-rename",
    "description": "Rename column elements to mayContain",
    "oldColumnName": "elements",
    "newColumnName": "mayContain"
  },
  {
    "op": "core/column-rename",
    "description": "Rename column element - elementName to elementName",
    "oldColumnName": "element - elementName",
    "newColumnName": "elementName"
  }
]