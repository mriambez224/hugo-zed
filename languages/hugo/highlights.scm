; Highlights for Hugo templates (tree-sitter-go-template grammar).
; Node names follow that grammar's own queries/highlights.scm.
; Function lists are derived from budparr/language-hugo-vscode (Apache-2.0).
;
; Later patterns override earlier ones, so the Hugo-specific rules come last.
; If builtins don't win over plain functions in your Zed version, move the
; "Hugo builtins" block above "Function calls".

; Identifiers

[
    (field)
    (field_identifier)
] @property

(variable) @variable.hugo

; Function calls

(function_call
    function: (identifier) @function)

(method_call
    method: (selector_expression
        field: (field_identifier) @function))

; Operators

"|" @operator
":=" @operator

; Delimiters
; The *.hugo captures fall back to the normal styles and can be recoloured
; per-theme via theme_overrides -> syntax in settings.json.

"." @punctuation.delimiter
"," @punctuation.delimiter

"{{" @punctuation.bracket.hugo
"}}" @punctuation.bracket.hugo
"{{-" @punctuation.bracket.hugo
"-}}" @punctuation.bracket.hugo
")" @punctuation.bracket
"(" @punctuation.bracket

; Keywords

"else" @keyword
"if" @keyword
"range" @keyword
"with" @keyword
"end" @keyword
"template" @keyword
"define" @keyword
"block" @keyword

; Literals

[
    (interpreted_string_literal)
    (raw_string_literal)
    (rune_literal)
] @string

(escape_sequence) @string.special

[
    (int_literal)
    (float_literal)
    (imaginary_literal)
] @number

[
    (true)
    (false)
    (nil)
] @constant.builtin

(comment) @comment

; ---- Hugo builtins ----

; Coloured as keywords in the VS Code tmLanguage (keyword.control.hugo)
((identifier) @keyword
    (#any-of? @keyword "partial" "partialCached" "return" "where"))

; Go template builtins + undotted Hugo functions
((identifier) @function.builtin
    (#any-of? @function.builtin
        "absLangURL" "absURL" "add" "after" "anchorize" "and" "any" "append" "apply" "babel"
        "base64Decode" "base64Encode" "call" "chomp" "complement" "cond" "countrunes"
        "countwords" "dateFormat" "default" "delimit" "dict" "div" "duration" "emojify" "eq"
        "errorf" "erroridf" "fileExists" "findRE" "findRESubmatch" "fingerprint" "first"
        "float" "ge" "getCSV" "getJSON" "getenv" "group" "gt" "hasPrefix" "hasSuffix"
        "highlight" "hmac" "html" "htmlEscape" "htmlUnescape" "humanize" "i18n" "in" "index"
        "int" "intersect" "isset" "js" "jsonify" "keyVals" "last" "le" "len" "lower" "lt"
        "markdownify" "md5" "merge" "minify" "mod" "modBool" "mul" "ne" "newScratch" "not"
        "now" "or" "page" "plainify" "pluralize" "postCSS" "pow" "print" "printf" "println"
        "querify" "readDir" "readFile" "ref" "relLangURL" "relURL" "relref" "replace"
        "replaceRE" "safeCSS" "safeHTML" "safeHTMLAttr" "safeJS" "safeJSStr" "safeURL" "seq"
        "sha1" "sha256" "shuffle" "singularize" "site" "slice" "slicestr" "sort" "split"
        "string" "sub" "substr" "symdiff" "time" "title" "toCSS" "trim" "truncate" "union"
        "uniq" "unmarshal" "upper" "urlize" "urlquery" "warnf"))

; Namespaced functions (strings.Replace, collections.Where, ...).
; How these parse depends on the grammar revision; this matches the
; selector_expression text. Verify with a real template.
((selector_expression) @function.builtin
    (#match? @function.builtin "^(cast\\.ToFloat|cast\\.ToInt|cast\\.ToString|collections\\.After|collections\\.Append|collections\\.Apply|collections\\.Complement|collections\\.Delimit|collections\\.Dictionary|collections\\.First|collections\\.Group|collections\\.In|collections\\.Index|collections\\.Intersect|collections\\.IsSet|collections\\.KeyVals|collections\\.Last|collections\\.Merge|collections\\.NewScratch|collections\\.Querify|collections\\.Reverse|collections\\.Seq|collections\\.Shuffle|collections\\.Slice|collections\\.Sort|collections\\.Union|collections\\.Uniq|collections\\.Where|compare\\.Conditional|compare\\.Default|compare\\.Eq|compare\\.Ge|compare\\.Gt|compare\\.Le|compare\\.Lt|compare\\.Ne|crypto\\.FNV32a|crypto\\.HMAC|crypto\\.MD5|crypto\\.SHA1|crypto\\.SHA256|data\\.GetCSV|data\\.GetJSON|debug\\.Dump|debug\\.Timer|diagrams\\.Goat|encoding\\.Base64Decode|encoding\\.Base64Encode|encoding\\.Jsonify|fmt\\.Errorf|fmt\\.Erroridf|fmt\\.Print|fmt\\.Printf|fmt\\.Println|fmt\\.Warnf|hugo\\.BuildDate|hugo\\.CommitHash|hugo\\.Deps|hugo\\.Environment|hugo\\.Generator|hugo\\.GoVersion|hugo\\.IsDevelopment|hugo\\.IsExtended|hugo\\.IsProduction|hugo\\.IsServer|hugo\\.Version|hugo\\.WorkingDir|images\\.AutoOrient|images\\.Brightness|images\\.ColorBalance|images\\.Colorize|images\\.Config|images\\.Contrast|images\\.Filter|images\\.Gamma|images\\.GaussianBlur|images\\.Grayscale|images\\.Hue|images\\.Invert|images\\.Opacity|images\\.Overlay|images\\.Padding|images\\.Pixelate|images\\.Process|images\\.Saturation|images\\.Sepia|images\\.Sigmoid|images\\.Text|images\\.UnsharpMask|inflect\\.Humanize|inflect\\.Pluralize|inflect\\.Singularize|js\\.Build|lang\\.FormatAccounting|lang\\.FormatCurrency|lang\\.FormatNumber|lang\\.FormatNumberCustom|lang\\.FormatPercent|lang\\.Merge|lang\\.Translate|math\\.Abs|math\\.Add|math\\.Ceil|math\\.Counter|math\\.Div|math\\.Floor|math\\.Log|math\\.Max|math\\.Min|math\\.Mod|math\\.ModBool|math\\.Mul|math\\.Pow|math\\.Product|math\\.Rand|math\\.Round|math\\.Sqrt|math\\.Sub|math\\.Sum|openapi3\\.Unmarshal|os\\.FileExists|os\\.Getenv|os\\.ReadDir|os\\.ReadFile|os\\.Stat|partials\\.Include|partials\\.IncludeCached|path\\.Base|path\\.BaseName|path\\.Clean|path\\.Dir|path\\.Ext|path\\.Join|path\\.Split|reflect\\.IsMap|reflect\\.IsSlice|resources\\.Babel|resources\\.ByType|resources\\.Concat|resources\\.Copy|resources\\.ExecuteAsTemplate|resources\\.Fingerprint|resources\\.FromString|resources\\.Get|resources\\.GetMatch|resources\\.GetRemote|resources\\.Match|resources\\.Minify|resources\\.PostCSS|resources\\.PostProcess|resources\\.ToCSS|safe\\.CSS|safe\\.HTML|safe\\.HTMLAttr|safe\\.JS|safe\\.JSStr|safe\\.URL|strings\\.Chomp|strings\\.Contains|strings\\.ContainsAny|strings\\.ContainsNonSpace|strings\\.Count|strings\\.CountRunes|strings\\.CountWords|strings\\.FindRE|strings\\.FindRESubmatch|strings\\.FirstUpper|strings\\.HasPrefix|strings\\.HasSuffix|strings\\.Repeat|strings\\.Replace|strings\\.ReplaceRE|strings\\.RuneCount|strings\\.SliceString|strings\\.Split|strings\\.Substr|strings\\.Title|strings\\.ToLower|strings\\.ToUpper|strings\\.Trim|strings\\.TrimLeft|strings\\.TrimPrefix|strings\\.TrimRight|strings\\.TrimSuffix|strings\\.Truncate|templates\\.Exists|time\\.AsTime|time\\.Duration|time\\.Format|time\\.Now|time\\.ParseDuration|transform\\.CanHighlight|transform\\.Emojify|transform\\.HTMLEscape|transform\\.HTMLUnescape|transform\\.Highlight|transform\\.HighlightCodeBlock|transform\\.Markdownify|transform\\.Plainify|transform\\.Remarshal|transform\\.Unmarshal|transform\\.XMLEscape|urls\\.AbsLangURL|urls\\.AbsURL|urls\\.Anchorize|urls\\.JoinPath|urls\\.Parse|urls\\.Ref|urls\\.RelLangURL|urls\\.RelRef|urls\\.RelURL|urls\\.URLize)$"))
