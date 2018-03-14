/*

 MyFonts Webfont Build ID 3514232, 2018-01-22T17:04:34-0500

 The fonts listed in this notice are subject to the End User License
 Agreement(s) entered into by the website owner. All other parties are 
 explicitly restricted from using the Licensed Webfonts(s).

 You may obtain a valid license at the URLs below.

 Webfont: ProximaNovaA-Bold by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/a-bold/

 Webfont: ProximaNovaA-BoldIt by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/a-bold-it/

 Webfont: ProximaNovaA-Light by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/a-light/

 Webfont: ProximaNovaA-Medium by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/a-medium/

 Webfont: ProximaNovaA-Regular by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/a-regular/

 Webfont: ProximaNovaA-Thin by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/a-thin/

 Webfont: ProximaNovaS-Bold by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/s-bold/

 Webfont: ProximaNovaS-BoldIt by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/s-bold-it/

 Webfont: ProximaNovaS-Light by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/s-light/

 Webfont: ProximaNovaS-Medium by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/s-medium/

 Webfont: ProximaNovaS-Regular by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/s-regular/

 Webfont: ProximaNovaS-Thin by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/s-thin/

 Webfont: ProximaNova-Bold by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/bold/

 Webfont: ProximaNova-BoldIt by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/bold-it/

 Webfont: ProximaNova-Light by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/light/

 Webfont: ProximaNova-Medium by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/medium/

 Webfont: ProximaNova-Regular by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/regular/

 Webfont: ProximaNovaT-Thin by Mark Simonson
 URL: https://www.myfonts.com/fonts/marksimonson/proxima-nova/thin/


 License: https://www.myfonts.com/viewlicense?type=web&buildid=3514232
 Licensed pageviews: 1,000,000
 Webfonts copyright: Copyright (c) Mark Simonson, 2005. All rights reserved.

 ? 2018 MyFonts Inc
*/
var protocol=document.location.protocol;"https:"!=protocol&&(protocol="http:");var count=document.createElement("script");count.type="text/javascript";count.async=!0;count.src=protocol+"//hello.myfonts.net/count/359f78";var s=document.getElementsByTagName("script")[0];s.parentNode.insertBefore(count,s);var browserName,browserVersion,webfontType;if("undefined"==typeof woffEnabled)var woffEnabled=!0;var svgEnabled=0,woff2Enabled=1;
if("undefined"!=typeof customPath)var path=customPath;else{var scripts=document.getElementsByTagName("SCRIPT"),script=scripts[scripts.length-1].src;script.match("://")||"/"==script.charAt(0)||(script="./"+script);path=script.replace(/\\/g,"/").replace(/\/[^\/]*\/?$/,"")}
var wfpath=path+"/webfonts/",browsers=[{regex:"MSIE (\\d+\\.\\d+)",versionRegex:"new Number(RegExp.$1)",type:[{version:9,type:"woff"},{version:5,type:"eot"}]},{regex:"Trident/(\\d+\\.\\d+); (.+)?rv:(\\d+\\.\\d+)",versionRegex:"new Number(RegExp.$3)",type:[{version:11,type:"woff"}]},{regex:"Firefox[/s](\\d+\\.\\d+)",versionRegex:"new Number(RegExp.$1)",type:[{version:3.6,type:"woff"},{version:3.5,type:"ttf"}]},{regex:"Edge/(\\d+\\.\\d+)",versionRegex:"new Number(RegExp.$1)",type:[{version:12,type:"woff"}]},
{regex:"Chrome/(\\d+\\.\\d+)",versionRegex:"new Number(RegExp.$1)",type:[{version:36,type:"woff2"},{version:6,type:"woff"},{version:4,type:"ttf"}]},{regex:"Mozilla.*Android (\\d+\\.\\d+).*AppleWebKit.*Safari",versionRegex:"new Number(RegExp.$1)",type:[{version:4.1,type:"woff"},{version:3.1,type:"svg#wf"},{version:2.2,type:"ttf"}]},{regex:"Mozilla.*(iPhone|iPad).* OS (\\d+)_(\\d+).* AppleWebKit.*Safari",versionRegex:"new Number(RegExp.$2) + (new Number(RegExp.$3) / 10)",unhinted:!0,type:[{version:5,
type:"woff"},{version:4.2,type:"ttf"},{version:1,type:"svg#wf"}]},{regex:"Mozilla.*(iPhone|iPad|BlackBerry).*AppleWebKit.*Safari",versionRegex:"1.0",type:[{version:1,type:"svg#wf"}]},{regex:"Version/(\\d+\\.\\d+)(\\.\\d+)? Safari/(\\d+\\.\\d+)",versionRegex:"new Number(RegExp.$1)",type:[{version:5.1,type:"woff"},{version:3.1,type:"ttf"}]},{regex:"Opera/(\\d+\\.\\d+)(.+)Version/(\\d+\\.\\d+)(\\.\\d+)?",versionRegex:"new Number(RegExp.$3)",type:[{version:24,type:"woff2"},{version:11.1,type:"woff"},
{version:10.1,type:"ttf"}]}],browLen=browsers.length,suffix="",i=0;
a:for(;i<browLen;i++){var regex=new RegExp(browsers[i].regex);if(regex.test(navigator.userAgent)){browserVersion=eval(browsers[i].versionRegex);var typeLen=browsers[i].type.length;for(j=0;j<typeLen;j++)if(browserVersion>=browsers[i].type[j].version&&(1==browsers[i].unhinted&&(suffix="_unhinted"),webfontType=browsers[i].type[j].type,"woff"!=webfontType||woffEnabled)&&("woff2"!=webfontType||woff2Enabled)&&("svg#wf"!=webfontType||svgEnabled))break a}else webfontType="woff"}
/(Macintosh|Android)/.test(navigator.userAgent)&&"svg#wf"!=webfontType&&(suffix="_unhinted");var head=document.getElementsByTagName("head")[0],stylesheet=document.createElement("style");stylesheet.setAttribute("type","text/css");head.appendChild(stylesheet);
for(var fonts=[{fontFamily:"ProximaNova-Bold",
url:wfpath+"359F78_C"+suffix+"_0."+webfontType},{fontFamily:"ProximaNova-BoldIt",url:wfpath+"359F78_D"+suffix+"_0."+webfontType},{fontFamily:"ProximaNova-Light",url:wfpath+"359F78_E"+suffix+"_0."+webfontType},{fontFamily:"ProximaNova-Medium",url:wfpath+"359F78_F"+suffix+"_0."+webfontType},{fontFamily:"ProximaNova-Regular",url:wfpath+"359F78_10"+suffix+"_0."+webfontType}],len=fonts.length,css="",i=0;i<len;i++){var format=
"svg#wf"==webfontType?'format("svg")':"ttf"==webfontType?'format("truetype")':"eot"==webfontType?"":'format("'+webfontType+'")',css=css+("@font-face{font-family: "+fonts[i].fontFamily+";src:url("+fonts[i].url+")"+format+";");fonts[i].fontWeight&&(css+="font-weight: "+fonts[i].fontWeight+";");fonts[i].fontStyle&&(css+="font-style: "+fonts[i].fontStyle+";");css+="}"}stylesheet.styleSheet?stylesheet.styleSheet.cssText=css:stylesheet.innerHTML=css;
