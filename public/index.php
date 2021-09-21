<?php
    $vars = require "../reccap_install.php";
?><!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

    <!-- Favicons -->
    <link rel="apple-touch-icon" href="/img/favicon.png" sizes="180x180">
    <link rel="icon" href="/img/favicon-32.png" sizes="32x32" type="image/png">
    <link rel="icon" href="/img/favicon-16.png" sizes="16x16" type="image/png">
    <link rel="icon" href="/img/favicon.png">

    <title><?= $vars["ServerName"] ?></title>
    
    <style>
      html,
        body {
          height: 100%;
        }

        body {
          display: -ms-flexbox;
          display: flex;
          -ms-flex-align: center;
          align-items: center;
          padding-top: 40px;
          padding-bottom: 40px;
          background-color: #f5f5f5;
        }

        .container {
          width: 100%;
          max-width: 800px;
          padding: 15px;
          margin: auto;
        }
    </style>
  </head>
  <body class="">
    <div class="container">
      <div class="text-center">
        <h1 class="h3 mb-3 font-weight-normal">
          <img class="rounded align-self-center" src="/img/favicon-64.png" alt="" width="48" height="48">
          <?= $vars["ServerName"] ?>
        </h1>
      </div>
      <div class="row mb-3">
        <div class="col-sm-auto mb-3">
          <ul class="list-group">
            <li class="list-group-item"><?= $vars["os"] ?></li>
            <li class="list-group-item">
              <img class="rounded" src="/img/apache.png" alt="">
              Apache
              <span class="badge badge-secondary float-right"><?= $vars["ApacheVersion"] ?></span>
            </li>
            <li class="list-group-item">
              <img class="rounded" src="/img/mysql.png" alt="">
              MySQL
              <span class="badge badge-secondary float-right"><?= $vars["MySQLVersion"] ?></span>
            </li>
            <li class="list-group-item">
              <img class="rounded" src="/img/php.png" alt="">
              PHP
              <span class="badge badge-secondary float-right"><?= $vars["PHPVersion"] ?></span>
            </li>
          </ul>
        </div>
        <div class="col-sm mb-3">
          <ul class="list-group">
            <li class="list-group-item">
              <img class="rounded" src="/img/certbot.png" alt="" width="16" height="16">
              Certbot
              <span class="badge badge-secondary float-right"><?= $vars["CertbotVersion"] ?></span>
            </li>
            <li class="list-group-item">
              <img class="rounded" src="/img/ufw.png" alt="" width="16" height="16">
              UFW
              <span class="badge badge-secondary float-right"><?= $vars["UFWVersion"] ?></span>
            </li>
            <li class="list-group-item">
              <img class="rounded" src="/img/fail2ban.ico" alt="" width="16" height="16">
              Fail2ban
              <span class="badge badge-secondary float-right"><?= $vars["Fail2banVersion"] ?></span>
            </li>
            <li class="list-group-item">
              <img class="rounded" src="/img/curl.ico" alt="" width="16" height="16">
              CURL
              <span class="badge badge-secondary float-right"><?= $vars["CURLVersion"] ?></span>
            </li>
          </ul>
        </div>
        <div class="col-sm mb-3">
          <ul class="list-group">
            <li class="list-group-item">
              <img class="rounded" src="/img/git.png" alt="" width="16" height="16">
              Git
              <span class="badge badge-secondary float-right"><?= $vars["GitVersion"] ?></span>
            </li>
            <li class="list-group-item">
              <img class="rounded" src="/img/nodejs.png" alt="" width="16" height="16">
              NodeJS
              <span class="badge badge-secondary float-right"><?= $vars["NodeJSVersion"] ?></span>
            </li>
            <li class="list-group-item">
              <img class="rounded" src="/img/npm.png" alt="" width="16" height="16">
              npm
              <span class="badge badge-secondary float-right"><?= $vars["npmVersion"] ?></span>
            </li>
            <li class="list-group-item">
              <img class="rounded" src="/img/composer.jpg" alt="" width="16" height="16">
              Composer
              <span class="badge badge-secondary float-right"><?= $vars["ComposerVersion"] ?></span>
            </li>
          </ul>
        </div>
      </div>
      <hr class="clearfix d-sm-block d-md-block d-lg-block">
      <div class="row justify-content-md-center">
        <div class="col">
          <h3 class="h5 ml-3 mb-3 font-weight-normal">
            VirtualHost 
            <span class="badge badge-dark"><?= count($vars["vhosts"]) ?></span>
          </h3>
          <ul class="list-group">
            <?php
              foreach ($vars["vhosts"] as $vhostName) {
                ?>
                <li class="list-group-item"><?= $vhostName ?></li>
                <?php
              }
              ?>
          </ul>
        </div>
        <div class="col">
          <h3 class="h5 ml-3 mb-3 font-weight-normal">
            Repositories 
            <span class="badge badge-dark"><?= count($vars["repos"]) ?></span>
          </h3>
          <ul class="list-group">
            <?php
              foreach ($vars["repos"] as $repoName) {
                ?>
                <li class="list-group-item"><kbd><?= $repoName ?></kbd></li>
                <?php
              }
              ?>
          </ul>
        </div>
      </div>

    </div>
  </body>
</html>
