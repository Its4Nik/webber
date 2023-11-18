#!/bin/bash


output="$1"

echo '
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport">
    <title>ItsNik</title>
    <link rel="stylesheet" type="text/css" href="//www.itsnik.de/blog/style.css?version=1">
</head>
<body>
    <div id="header">
        <div class="container">
            <nav>
                <img alt="$title - Logo" src="//www.itsnik.de/images/logo.png" class="logo">
                <ul>
                    <li><a href="//www.itsnik.de"> Home</a></li>
                    <li><a href="//www.itsnik.de/#about"> About</a></li>
                    <li><a href="//www.itsnik.de/#services"> Services</a></li>
                    <li><a href="//www.itsnik.de/blog"> Blog</a></li>
                    <li><a href="//www.itsnik.de/#contact"> Contact</a></li>
                </ul>
            </nav>
        </div>
    </div>
<header>
    <h1 class="heading">Welcome!</h1>
    <p>This Website is hosted on a Apache Webserver with some custom written bash scripts, to generate the landing page!</p>
    <p>There are also some JavaScripts embedded, for rendering Markdown and Code-Blocks</p>

</header>
' > $output


echo "=================================================="
echo "Processing index.html"
echo "Step 1 completed (adding headers and default text)"
echo