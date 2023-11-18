#!/bin/bash

input="$1"
path="${2}posts/"
output="$(basename "${input%.*}").html"
DATE="$(date +"%d.%m.%Y")"


echo '
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]>      <html class="no-js"> <!--<![endif]-->
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>ItsNiks Blog</title>
        <link rel="stylesheet" href="//www.itsnik.de/blog/style-posts.css">
        <link href="//www.itsnik.de/blog/prism.css" rel="stylesheet">
    </head>
    <body>
        <!--[if lt IE 7]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="#">upgrade your browser</a> to improve your experience.</p><![endif]-->
<md-block>' >> $path$DATE-$output