# fylr-fjc-plugin
Plugin to support FJC classes

## Installation

The latest version of this plugin can be found [here](https://github.com/programmfabrik/fylr-plugin-fjc/releases/latest/download/fylr-plugin-fjc.zip).

The ZIP can be downloaded and installed using the plugin manager, or used directly (recommended).

Github has an overwiew page to get a list of [all release](https://github.com/programmfabrik/fylr-plugin-fjc/releases/).

## Config endpoint

Use the following endpoints to work with preferences:

### `GET /api/v1/config/plugin/fjc/config`

Returns all preferences known to the plugin. Currently there is only `prefs` available.

For access the [GJSON Syntax](https://github.com/tidwall/gjson/blob/master/SYNTAX.md) is used. For that the path is converted to **GJSON** by replacing `/` with `.`. `.` is replaced by `\.`. Make sure to escape all path elements using the URL % escape notation. A `#` becomes a `%23`.

### `POST /api/v1/config/plugin/fjc/config/prefs`

Post all prefs, supported top level keys are:

* `viewsets`

To access deeper members of JSON data, [SJSON](https://github.com/tidwall/sjson) is used. The GET rules for path replacements are applied for SJSON too, see the Example section for an example.

## Examples

### Replace all prefs with new data

```bash
> curl -X 'POST' -d '{"viewsets": {"views": [{"a": "b"},{"c": "d"}]}}' -H "Authorization: Bearer $ACCESS_TOKEN" http://localhost/api/v1/config/plugin/fjc/config/prefs
{
    "viewsets": {
        "views": [
            {
                "a": "b"
            },
            {
                "c": "d"
            },
        ]
    },
    "viewsets:info": {
        "is_default": false
    }
}
```

### Append an deeper nested item

```bash
> curl -X 'POST' -d '{"e": "f"}' -H "Authorization: Bearer $ACCESS_TOKEN" http://localhost/api/v1/config/plugin/fjc/config/prefs/viewsets/views/-1
null
```
`null` is returned, because the `-1` doesn't work as a `GJSON` path.

### Delete the first item in viewsets.views

```bash
> curl -X 'DELETE' -H "Authorization: Bearer $ACCESS_TOKEN" http://localhost/api/v1/config/plugin/fjc/config/prefs/viewsets/views/0
{
    "c": "d"
}
```

### Get all prefs of the plugin

```bash
> curl -X 'GET' -H "Authorization: Bearer $ACCESS_TOKEN" http://localhost/api/v1/config/plugin/fjc/config
{
    "prefs": {
        "viewsets": {
            "views": [
                {
                    "c": "d"
                },
                {
                    "e": "f"
                }
            ]
        },
        "viewsets:info": {
            "is_default": false
        }
    }
}
```

### Deep filter prefs
```bash
> curl -X 'GET' -H "Authorization: Bearer $ACCESS_TOKEN" http://localhost/api/v1/config/plugin/fjc/config/prefs/viewsets/views/%23(c=d)/c"
"d"
```


