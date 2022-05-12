<!DOCTYPE html>

<html>

<head>

<meta charset="utf-8" />
<meta name="generator" content="pandoc" />
<meta http-equiv="X-UA-Compatible" content="IE=EDGE" />

<meta name="viewport" content="width=device-width, initial-scale=1" />



<title>multifractal</title>

<script>// Pandoc 2.9 adds attributes on both header and div. We remove the former (to
// be compatible with the behavior of Pandoc < 2.8).
document.addEventListener('DOMContentLoaded', function(e) {
  var hs = document.querySelectorAll("div.section[class*='level'] > :first-child");
  var i, h, a;
  for (i = 0; i < hs.length; i++) {
    h = hs[i];
    if (!/^h[1-6]$/i.test(h.tagName)) continue;  // it should be a header h1-h6
    a = h.attributes;
    while (a.length > 0) h.removeAttribute(a[0].name);
  }
});
</script>

<style type="text/css">
  code{white-space: pre-wrap;}
  span.smallcaps{font-variant: small-caps;}
  span.underline{text-decoration: underline;}
  div.column{display: inline-block; vertical-align: top; width: 50%;}
  div.hanging-indent{margin-left: 1.5em; text-indent: -1.5em;}
  ul.task-list{list-style: none;}
    </style>



<style type="text/css">
  code {
    white-space: pre;
  }
  .sourceCode {
    overflow: visible;
  }
</style>
<style type="text/css" data-origin="pandoc">
pre > code.sourceCode { white-space: pre; position: relative; }
pre > code.sourceCode > span { display: inline-block; line-height: 1.25; }
pre > code.sourceCode > span:empty { height: 1.2em; }
.sourceCode { overflow: visible; }
code.sourceCode > span { color: inherit; text-decoration: inherit; }
div.sourceCode { margin: 1em 0; }
pre.sourceCode { margin: 0; }
@media screen {
div.sourceCode { overflow: auto; }
}
@media print {
pre > code.sourceCode { white-space: pre-wrap; }
pre > code.sourceCode > span { text-indent: -5em; padding-left: 5em; }
}
pre.numberSource code
  { counter-reset: source-line 0; }
pre.numberSource code > span
  { position: relative; left: -4em; counter-increment: source-line; }
pre.numberSource code > span > a:first-child::before
  { content: counter(source-line);
    position: relative; left: -1em; text-align: right; vertical-align: baseline;
    border: none; display: inline-block;
    -webkit-touch-callout: none; -webkit-user-select: none;
    -khtml-user-select: none; -moz-user-select: none;
    -ms-user-select: none; user-select: none;
    padding: 0 4px; width: 4em;
    color: #aaaaaa;
  }
pre.numberSource { margin-left: 3em; border-left: 1px solid #aaaaaa;  padding-left: 4px; }
div.sourceCode
  {   }
@media screen {
pre > code.sourceCode > span > a:first-child::before { text-decoration: underline; }
}
code span.al { color: #ff0000; font-weight: bold; } /* Alert */
code span.an { color: #60a0b0; font-weight: bold; font-style: italic; } /* Annotation */
code span.at { color: #7d9029; } /* Attribute */
code span.bn { color: #40a070; } /* BaseN */
code span.bu { } /* BuiltIn */
code span.cf { color: #007020; font-weight: bold; } /* ControlFlow */
code span.ch { color: #4070a0; } /* Char */
code span.cn { color: #880000; } /* Constant */
code span.co { color: #60a0b0; font-style: italic; } /* Comment */
code span.cv { color: #60a0b0; font-weight: bold; font-style: italic; } /* CommentVar */
code span.do { color: #ba2121; font-style: italic; } /* Documentation */
code span.dt { color: #902000; } /* DataType */
code span.dv { color: #40a070; } /* DecVal */
code span.er { color: #ff0000; font-weight: bold; } /* Error */
code span.ex { } /* Extension */
code span.fl { color: #40a070; } /* Float */
code span.fu { color: #06287e; } /* Function */
code span.im { } /* Import */
code span.in { color: #60a0b0; font-weight: bold; font-style: italic; } /* Information */
code span.kw { color: #007020; font-weight: bold; } /* Keyword */
code span.op { color: #666666; } /* Operator */
code span.ot { color: #007020; } /* Other */
code span.pp { color: #bc7a00; } /* Preprocessor */
code span.sc { color: #4070a0; } /* SpecialChar */
code span.ss { color: #bb6688; } /* SpecialString */
code span.st { color: #4070a0; } /* String */
code span.va { color: #19177c; } /* Variable */
code span.vs { color: #4070a0; } /* VerbatimString */
code span.wa { color: #60a0b0; font-weight: bold; font-style: italic; } /* Warning */

</style>
<script>
// apply pandoc div.sourceCode style to pre.sourceCode instead
(function() {
  var sheets = document.styleSheets;
  for (var i = 0; i < sheets.length; i++) {
    if (sheets[i].ownerNode.dataset["origin"] !== "pandoc") continue;
    try { var rules = sheets[i].cssRules; } catch (e) { continue; }
    for (var j = 0; j < rules.length; j++) {
      var rule = rules[j];
      // check if there is a div.sourceCode rule
      if (rule.type !== rule.STYLE_RULE || rule.selectorText !== "div.sourceCode") continue;
      var style = rule.style.cssText;
      // check if color or background-color is set
      if (rule.style.color === '' && rule.style.backgroundColor === '') continue;
      // replace div.sourceCode by a pre.sourceCode rule
      sheets[i].deleteRule(j);
      sheets[i].insertRule('pre.sourceCode{' + style + '}', j);
    }
  }
})();
</script>




<style type="text/css">body {
background-color: #fff;
margin: 1em auto;
max-width: 700px;
overflow: visible;
padding-left: 2em;
padding-right: 2em;
font-family: "Open Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
font-size: 14px;
line-height: 1.35;
}
#TOC {
clear: both;
margin: 0 0 10px 10px;
padding: 4px;
width: 400px;
border: 1px solid #CCCCCC;
border-radius: 5px;
background-color: #f6f6f6;
font-size: 13px;
line-height: 1.3;
}
#TOC .toctitle {
font-weight: bold;
font-size: 15px;
margin-left: 5px;
}
#TOC ul {
padding-left: 40px;
margin-left: -1.5em;
margin-top: 5px;
margin-bottom: 5px;
}
#TOC ul ul {
margin-left: -2em;
}
#TOC li {
line-height: 16px;
}
table {
margin: 1em auto;
border-width: 1px;
border-color: #DDDDDD;
border-style: outset;
border-collapse: collapse;
}
table th {
border-width: 2px;
padding: 5px;
border-style: inset;
}
table td {
border-width: 1px;
border-style: inset;
line-height: 18px;
padding: 5px 5px;
}
table, table th, table td {
border-left-style: none;
border-right-style: none;
}
table thead, table tr.even {
background-color: #f7f7f7;
}
p {
margin: 0.5em 0;
}
blockquote {
background-color: #f6f6f6;
padding: 0.25em 0.75em;
}
hr {
border-style: solid;
border: none;
border-top: 1px solid #777;
margin: 28px 0;
}
dl {
margin-left: 0;
}
dl dd {
margin-bottom: 13px;
margin-left: 13px;
}
dl dt {
font-weight: bold;
}
ul {
margin-top: 0;
}
ul li {
list-style: circle outside;
}
ul ul {
margin-bottom: 0;
}
pre, code {
background-color: #f7f7f7;
border-radius: 3px;
color: #333;
white-space: pre-wrap; 
}
pre {
border-radius: 3px;
margin: 5px 0px 10px 0px;
padding: 10px;
}
pre:not([class]) {
background-color: #f7f7f7;
}
code {
font-family: Consolas, Monaco, 'Courier New', monospace;
font-size: 85%;
}
p > code, li > code {
padding: 2px 0px;
}
div.figure {
text-align: center;
}
img {
background-color: #FFFFFF;
padding: 2px;
border: 1px solid #DDDDDD;
border-radius: 3px;
border: 1px solid #CCCCCC;
margin: 0 5px;
}
h1 {
margin-top: 0;
font-size: 35px;
line-height: 40px;
}
h2 {
border-bottom: 4px solid #f7f7f7;
padding-top: 10px;
padding-bottom: 2px;
font-size: 145%;
}
h3 {
border-bottom: 2px solid #f7f7f7;
padding-top: 10px;
font-size: 120%;
}
h4 {
border-bottom: 1px solid #f7f7f7;
margin-left: 8px;
font-size: 105%;
}
h5, h6 {
border-bottom: 1px solid #ccc;
font-size: 105%;
}
a {
color: #0033dd;
text-decoration: none;
}
a:hover {
color: #6666ff; }
a:visited {
color: #800080; }
a:visited:hover {
color: #BB00BB; }
a[href^="http:"] {
text-decoration: underline; }
a[href^="https:"] {
text-decoration: underline; }

code > span.kw { color: #555; font-weight: bold; } 
code > span.dt { color: #902000; } 
code > span.dv { color: #40a070; } 
code > span.bn { color: #d14; } 
code > span.fl { color: #d14; } 
code > span.ch { color: #d14; } 
code > span.st { color: #d14; } 
code > span.co { color: #888888; font-style: italic; } 
code > span.ot { color: #007020; } 
code > span.al { color: #ff0000; font-weight: bold; } 
code > span.fu { color: #900; font-weight: bold; } 
code > span.er { color: #a61717; background-color: #e3d2d2; } 
</style>




</head>

<body>




<h1 class="title toc-ignore">multifractal</h1>



<div id="overview" class="section level2">
<h2>Overview</h2>
<p>This is an improved package for multifractal detrended fluctuation
(MF-DFA) and surroagte analysis (IAAFT, IAAWT). It allows to enhance the
robustness and reliability of classic MF-DFA via overlapping windows. It
further enables to test the significance of multifractality via IAAFT
surrogates.</p>
</div>
<div id="installation" class="section level2">
<h2>Installation</h2>
<div class="sourceCode" id="cb1"><pre class="sourceCode r"><code class="sourceCode r"><span id="cb1-1"><a href="#cb1-1" aria-hidden="true" tabindex="-1"></a>devtools<span class="sc">::</span><span class="fu">install_github</span>(<span class="st">&quot;wol-fi/multifractal&quot;</span>)</span></code></pre></div>
</div>
<div id="usage" class="section level2">
<h2>Usage</h2>
<p>The below example illustrates a multifractal analysis of the S&amp;P
500 stock market index (daily, 1992-2022). The example dataset comes
with the package (source: Yahoo finance).</p>
<div class="sourceCode" id="cb2"><pre class="sourceCode r"><code class="sourceCode r"><span id="cb2-1"><a href="#cb2-1" aria-hidden="true" tabindex="-1"></a><span class="fu">library</span>(multifractal)</span>
<span id="cb2-2"><a href="#cb2-2" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb2-3"><a href="#cb2-3" aria-hidden="true" tabindex="-1"></a><span class="do">## preparation:</span></span>
<span id="cb2-4"><a href="#cb2-4" aria-hidden="true" tabindex="-1"></a><span class="co"># load the example dataset &#39;sp500&#39; and calculate daily log-returns</span></span>
<span id="cb2-5"><a href="#cb2-5" aria-hidden="true" tabindex="-1"></a>p <span class="ot">&lt;-</span> sp500</span>
<span id="cb2-6"><a href="#cb2-6" aria-hidden="true" tabindex="-1"></a>r <span class="ot">&lt;-</span> <span class="fu">diff</span>(<span class="fu">log</span>(p<span class="sc">$</span>Adj.Close)) </span>
<span id="cb2-7"><a href="#cb2-7" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb2-8"><a href="#cb2-8" aria-hidden="true" tabindex="-1"></a><span class="do">## multifractal analysis</span></span>
<span id="cb2-9"><a href="#cb2-9" aria-hidden="true" tabindex="-1"></a><span class="co"># estimate the statistics</span></span>
<span id="cb2-10"><a href="#cb2-10" aria-hidden="true" tabindex="-1"></a>mdl <span class="ot">&lt;-</span> <span class="fu">mfdfa</span>(r, <span class="at">overlap=</span>T)</span>
<span id="cb2-11"><a href="#cb2-11" aria-hidden="true" tabindex="-1"></a><span class="co">#&gt; ....................</span></span>
<span id="cb2-12"><a href="#cb2-12" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb2-13"><a href="#cb2-13" aria-hidden="true" tabindex="-1"></a><span class="do">## plot the output</span></span>
<span id="cb2-14"><a href="#cb2-14" aria-hidden="true" tabindex="-1"></a><span class="fu">plot</span>(mdl, <span class="at">newindow=</span>F)</span></code></pre></div>
<p><img src="data:image/png;base64,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" /><!-- --></p>
<div class="sourceCode" id="cb3"><pre class="sourceCode r"><code class="sourceCode r"><span id="cb3-1"><a href="#cb3-1" aria-hidden="true" tabindex="-1"></a><span class="co"># Interpretation:</span></span>
<span id="cb3-2"><a href="#cb3-2" aria-hidden="true" tabindex="-1"></a><span class="co">#  - upper-left: Fluctuation plot. The slopes of the lines represent the Hurst exponents</span></span>
<span id="cb3-3"><a href="#cb3-3" aria-hidden="true" tabindex="-1"></a><span class="co">#                (one line per moment q). If the lines are parallel then the series is monofractal </span></span>
<span id="cb3-4"><a href="#cb3-4" aria-hidden="true" tabindex="-1"></a><span class="co">#                (e.g., classic Brownian motion), otherwise multifractal. </span></span>
<span id="cb3-5"><a href="#cb3-5" aria-hidden="true" tabindex="-1"></a><span class="co">#  - upper-right: Multifractal spectrum. The wider, the stronger the degree of multifractality and </span></span>
<span id="cb3-6"><a href="#cb3-6" aria-hidden="true" tabindex="-1"></a><span class="co">#                non-linear auto-correlation. Hölder exponents are abbreviated by $\alpha$.</span></span>
<span id="cb3-7"><a href="#cb3-7" aria-hidden="true" tabindex="-1"></a><span class="co">#  - lower-left: generalized Hurst exponents. Would be approximately flat if monofractal.</span></span>
<span id="cb3-8"><a href="#cb3-8" aria-hidden="true" tabindex="-1"></a><span class="co">#  - lower-right: Scaling function. Is linear if monofractal, otherwise convex. </span></span>
<span id="cb3-9"><a href="#cb3-9" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb3-10"><a href="#cb3-10" aria-hidden="true" tabindex="-1"></a><span class="do">## Extract Persistence and Multifractal Strength</span></span>
<span id="cb3-11"><a href="#cb3-11" aria-hidden="true" tabindex="-1"></a>stats <span class="ot">&lt;-</span> <span class="fu">print</span>(mdl)</span>
<span id="cb3-12"><a href="#cb3-12" aria-hidden="true" tabindex="-1"></a><span class="co">#&gt; </span></span>
<span id="cb3-13"><a href="#cb3-13" aria-hidden="true" tabindex="-1"></a><span class="co">#&gt; Persistence: </span></span>
<span id="cb3-14"><a href="#cb3-14" aria-hidden="true" tabindex="-1"></a><span class="co">#&gt;  0.4634505   ... =  anti-persistent, neg. auto-corr. </span></span>
<span id="cb3-15"><a href="#cb3-15" aria-hidden="true" tabindex="-1"></a><span class="co">#&gt; </span></span>
<span id="cb3-16"><a href="#cb3-16" aria-hidden="true" tabindex="-1"></a><span class="co">#&gt; Multifractal Strength:</span></span>
<span id="cb3-17"><a href="#cb3-17" aria-hidden="true" tabindex="-1"></a><span class="co">#&gt;  diff. Hurst =  0.1146917 </span></span>
<span id="cb3-18"><a href="#cb3-18" aria-hidden="true" tabindex="-1"></a><span class="co">#&gt;  diff. Hölder =  0.2261127</span></span>
<span id="cb3-19"><a href="#cb3-19" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb3-20"><a href="#cb3-20" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb3-21"><a href="#cb3-21" aria-hidden="true" tabindex="-1"></a><span class="do">## Test Significance</span></span>
<span id="cb3-22"><a href="#cb3-22" aria-hidden="true" tabindex="-1"></a>sig <span class="ot">&lt;-</span> <span class="fu">significance</span>(mdl, <span class="at">size=</span><span class="dv">10</span>, <span class="at">pval=</span><span class="fl">0.1</span>)</span>
<span id="cb3-23"><a href="#cb3-23" aria-hidden="true" tabindex="-1"></a><span class="co">#&gt; ..........</span></span>
<span id="cb3-24"><a href="#cb3-24" aria-hidden="true" tabindex="-1"></a><span class="co">#&gt;          diff_Holder</span></span>
<span id="cb3-25"><a href="#cb3-25" aria-hidden="true" tabindex="-1"></a><span class="co">#&gt; original   0.2261127</span></span>
<span id="cb3-26"><a href="#cb3-26" aria-hidden="true" tabindex="-1"></a><span class="co">#&gt; 90% C.I.   0.2176705</span></span>
<span id="cb3-27"><a href="#cb3-27" aria-hidden="true" tabindex="-1"></a><span class="co">#&gt; </span></span>
<span id="cb3-28"><a href="#cb3-28" aria-hidden="true" tabindex="-1"></a><span class="co">#&gt;  multifractality is significant</span></span></code></pre></div>
</div>



<!-- code folding -->


<!-- dynamically load mathjax for compatibility with self-contained -->
<script>
  (function () {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src  = "https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML";
    document.getElementsByTagName("head")[0].appendChild(script);
  })();
</script>

</body>
</html>
