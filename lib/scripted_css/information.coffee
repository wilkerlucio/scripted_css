# Copyright (c) 2011 Wilker Lúcio
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

(($) ->
  ScriptedCss.Information =
    backgroundAttachments:
      "fixed":  true
      "scroll": true

    backgroundPositions:
      "left":   true
      "center": true
      "right":  true
      "top":    true
      "bottom": true

    backgroundRepeats:
      "repeat":    true
      "repeat-x":  true
      "repeat-y":  true
      "no-repeat": true

    borderStyles:
      "none":   true
      "hidden": true
      "dotted": true
      "dashed": true
      "solid":  true
      "double": true
      "groove": true
      "ridge":  true
      "inset":  true
      "outset": true

    borderWidths:
      "thin":   true
      "medium": true
      "thick":  true

    # list of all standart css colors
    colors:
      "aliceblue":            "#f0f8ff"
      "antiquewhite":         "#faebd7"
      "aqua":                 "#00ffff"
      "aquamarine":           "#7fffd4"
      "azure":                "#f0ffff"
      "beige":                "#f5f5dc"
      "bisque":               "#ffe4c4"
      "black":                "#000000"
      "blanchedalmond":       "#ffebcd"
      "blue":                 "#0000ff"
      "blueviolet":           "#8a2be2"
      "brown":                "#a52a2a"
      "burlywood":            "#deb887"
      "cadetblue":            "#5f9ea0"
      "chartreuse":           "#7fff00"
      "chocolate":            "#d2691e"
      "coral":                "#ff7f50"
      "cornflowerblue":       "#6495ed"
      "cornsilk":             "#fff8dc"
      "crimson":              "#dc143c"
      "cyan":                 "#00ffff"
      "darkblue":             "#00008b"
      "darkcyan":             "#008b8b"
      "darkgoldenrod":        "#b8860b"
      "darkgray":             "#a9a9a9"
      "darkgrey":             "#a9a9a9"
      "darkgreen":            "#006400"
      "darkkhaki":            "#bdb76b"
      "darkmagenta":          "#8b008b"
      "darkolivegreen":       "#556b2f"
      "darkorange":           "#ff8c00"
      "darkorchid":           "#9932cc"
      "darkred":              "#8b0000"
      "darksalmon":           "#e9967a"
      "darkseagreen":         "#8fbc8f"
      "darkslateblue":        "#483d8b"
      "darkslategray":        "#2f4f4f"
      "darkslategrey":        "#2f4f4f"
      "darkturquoise":        "#00ced1"
      "darkviolet":           "#9400d3"
      "deeppink":             "#ff1493"
      "deepskyblue":          "#00bfff"
      "dimgray":              "#696969"
      "dimgrey":              "#696969"
      "dodgerblue":           "#1e90ff"
      "firebrick":            "#b22222"
      "floralwhite":          "#fffaf0"
      "forestgreen":          "#228b22"
      "fuchsia":              "#ff00ff"
      "gainsboro":            "#dcdcdc"
      "ghostwhite":           "#f8f8ff"
      "gold":                 "#ffd700"
      "goldenrod":            "#daa520"
      "gray":                 "#808080"
      "grey":                 "#808080"
      "green":                "#008000"
      "greenyellow":          "#adff2f"
      "honeydew":             "#f0fff0"
      "hotpink":              "#ff69b4"
      "indianred":            "#cd5c5c"
      "indigo":               "#4b0082"
      "ivory":                "#fffff0"
      "khaki":                "#f0e68c"
      "lavender":             "#e6e6fa"
      "lavenderblush":        "#fff0f5"
      "lawngreen":            "#7cfc00"
      "lemonchiffon":         "#fffacd"
      "lightblue":            "#add8e6"
      "lightcoral":           "#f08080"
      "lightcyan":            "#e0ffff"
      "lightgoldenrodyellow": "#fafad2"
      "lightgray":            "#d3d3d3"
      "lightgrey":            "#d3d3d3"
      "lightgreen":           "#90ee90"
      "lightpink":            "#ffb6c1"
      "lightsalmon":          "#ffa07a"
      "lightseagreen":        "#20b2aa"
      "lightskyblue":         "#87cefa"
      "lightslategray":       "#778899"
      "lightslategrey":       "#778899"
      "lightsteelblue":       "#b0c4de"
      "lightyellow":          "#ffffe0"
      "lime":                 "#00ff00"
      "limegreen":            "#32cd32"
      "linen":                "#faf0e6"
      "magenta":              "#ff00ff"
      "maroon":               "#800000"
      "mediumaquamarine":     "#66cdaa"
      "mediumblue":           "#0000cd"
      "mediumorchid":         "#ba55d3"
      "mediumpurple":         "#9370d8"
      "mediumseagreen":       "#3cb371"
      "mediumslateblue":      "#7b68ee"
      "mediumspringgreen":    "#00fa9a"
      "mediumturquoise":      "#48d1cc"
      "mediumvioletred":      "#c71585"
      "midnightblue":         "#191970"
      "mintcream":            "#f5fffa"
      "mistyrose":            "#ffe4e1"
      "moccasin":             "#ffe4b5"
      "navajowhite":          "#ffdead"
      "navy":                 "#000080"
      "oldlace":              "#fdf5e6"
      "olive":                "#808000"
      "olivedrab":            "#6b8e23"
      "orange":               "#ffa500"
      "orangered":            "#ff4500"
      "orchid":               "#da70d6"
      "palegoldenrod":        "#eee8aa"
      "palegreen":            "#98fb98"
      "paleturquoise":        "#afeeee"
      "palevioletred":        "#d87093"
      "papayawhip":           "#ffefd5"
      "peachpuff":            "#ffdab9"
      "peru":                 "#cd853f"
      "pink":                 "#ffc0cb"
      "plum":                 "#dda0dd"
      "powderblue":           "#b0e0e6"
      "purple":               "#800080"
      "red":                  "#ff0000"
      "rosybrown":            "#bc8f8f"
      "royalblue":            "#4169e1"
      "saddlebrown":          "#8b4513"
      "salmon":               "#fa8072"
      "sandybrown":           "#f4a460"
      "seagreen":             "#2e8b57"
      "seashell":             "#fff5ee"
      "sienna":               "#a0522d"
      "silver":               "#c0c0c0"
      "skyblue":              "#87ceeb"
      "slateblue":            "#6a5acd"
      "slategray":            "#708090"
      "slategrey":            "#708090"
      "snow":                 "#fffafa"
      "springgreen":          "#00ff7f"
      "steelblue":            "#4682b4"
      "tan":                  "#d2b48c"
      "teal":                 "#008080"
      "thistle":              "#d8bfd8"
      "tomato":               "#ff6347"
      "turquoise":            "#40e0d0"
      "violet":               "#ee82ee"
      "wheat":                "#f5deb3"
      "white":                "#ffffff"
      "whitesmoke":           "#f5f5f5"
      "yellow":               "#ffff00"
      "yellowgreen":          "#9acd32"
      "transparent":          true      # special color

    fontSizes:
      "xx-small": true
      "x-small":  true
      "small":    true
      "medium":   true
      "large":    true
      "x-large":  true
      "xx-large": true
      "smaller":  true
      "larger":   true

    fontStyles:
      "italic":  true
      "oblique": true

    fontVariants:
      "small-caps": true

    fontWeights:
      "bold":    "700"
      "bolder":  true
      "lighter": true
      "100":     true
      "200":     true
      "300":     true
      "400":     true
      "500":     true
      "600":     true
      "700":     true
      "800":     true
      "900":     true

    listTypes:
      "circle":               true
      "disc":                 true
      "square":               true
      "armenian":             true
      "decimal":              true
      "decimal-leading-zero": true
      "georgian":             true
      "lower-alpha":          true
      "lower-greek":          true
      "lower-latin":          true
      "lower-roman":          true
      "upper-alpha":          true
      "upper-latin":          true
      "upper-roman":          true

    listPositions:
      "inside":  true
      "outside": true

    attributeGrammar:
      # font grammar, based on CSS 2.1 specification: http://www.w3.org/TR/2010/WD-CSS2-20101207/fonts.html
      "font-family":
        value: "[[ <family-name> | <generic-family> ] [, <family-name> | <generic-family> ]*] | inherit"
        return: (v) -> if v.get(1) then [_.flatten([v.get(0)].concat(v.get(1)))] else v.results

      "font-weight": "normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 | inherit"
      "font-style": "normal | italic | oblique | inherit"
      "font-variant": "normal | small-caps | inherit"
      "font-size": "<absolute-size> | <relative-size> | <length> | <percentage> | inherit"
      "font":
        value: "[ [ <font-style> || <font-variant> || <font-weight> ]? <font-size> [ / <line-height> ]? <font-family> ] | caption | icon | menu | message-box | small-caption | status-bar | inherit"
        return: (v) ->
          return v.results unless v.isList()

          style:      v.get(0, 0)
          variant:    v.get(0, 1)
          weight:     v.get(0, 2)
          size:       v.get(1)
          lineHeight: v.get(2, 1)
          family:     v.get(3)

      "generic-family": "serif | sans-serif | cursive | fantasy | monospace"
      "family-name": "<literal> | <string>"

      # common grammar
      "absolute-size": "xx-small | x-small | small | medium | large | x-large | xx-large"
      "line-height": "normal | <number> | <length> | <percentage> | inherit"
      "relative-size": "larger | smaller"

      # internal grammar
      "literal": (nodes) -> @collect nodes, (node) -> node.type == "LITERAL"
      "string": (nodes) -> @collect nodes, (node) -> node.type == "STRING"
      "length": (nodes) -> @collect nodes, (node) -> node.type == "UNIT_NUMBER"
      "percentage": (nodes) -> @collect nodes, (node) -> node.type == "PERCENT"
      "number": (nodes) -> @collect nodes, (node) -> node.type == "NUMBER"

)(jQuery)
