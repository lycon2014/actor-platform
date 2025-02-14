package im.actor

import sbt.Keys._
import sbt._
import spray.revolver.RevolverPlugin._
import com.trueaccord.scalapb.{ScalaPbPlugin => PB}

object Build extends sbt.Build with Versioning with Releasing with Publishing {
  val ScalaVersion = "2.11.7"
  val BotKitVersion = getVersion

  lazy val buildSettings =
    Defaults.coreDefaultSettings ++
      Seq(
        //version := Version,
        scalaVersion := ScalaVersion,
        scalaVersion in ThisBuild := ScalaVersion,
        crossPaths := false,
        organization := "im.actor.server",
        organizationHomepage := Some(url("https://actor.im"))
      ) ++ Sonatype.sonatypeSettings

  lazy val compilerWarnings = Seq(
    "-Ywarn-dead-code",
    "-Ywarn-infer-any",
    "-Ywarn-numeric-widen"
  )

  lazy val defaultScalacOptions = Seq(
    "-target:jvm-1.8",
    "-Ybackend:GenBCode",
    "-Ydelambdafy:method",
    "-Yopt:l:classpath",
    //"-Ymacro-debug-lite",
    "-encoding", "UTF-8",
    "-deprecation",
    "-unchecked",
    "-feature",
    "-language:higherKinds",
    "-Xfatal-warnings",
    "-Xlint",
    "-Xfuture"
  ) ++ compilerWarnings

  lazy val defaultSettings =
    buildSettings ++ Formatting.formatSettings ++
      PB.protobufSettings ++ Seq(
      //PB.javaConversions in PB.protobufConfig := true,
      libraryDependencies += "com.trueaccord.scalapb" %% "scalapb-runtime" % "0.5.17" % PB.protobufConfig,
      PB.includePaths in PB.protobufConfig ++= Seq(
        file("actor-models/src/main/protobuf"),
        file("actor-core/src/main/protobuf")
      ),
      PB.runProtoc in PB.protobufConfig := (args =>
        com.github.os72.protocjar.Protoc.runProtoc("-v300" +: args.toArray))
    ) ++
      Seq(
        initialize ~= { _ =>
          if (sys.props("java.specification.version") != "1.8")
            sys.error("Java 8 is required for this project.")
        },
        resolvers ++= Resolvers.seq,
        scalacOptions in Compile ++= defaultScalacOptions,
        javaOptions ++= Seq("-Dfile.encoding=UTF-8"),
        javacOptions ++= Seq("-source", "1.8", "-target", "1.8", "-Xlint:unchecked", "-Xlint:deprecation"),
        fork in Test := false,
        updateOptions := updateOptions.value.withCachedResolution(true)
      )


  lazy val root = Project(
    "actor",
    file("."),
    settings =
      defaultSettings ++
        Revolver.settings ++
        Seq(
          libraryDependencies ++= Dependencies.root,
          //Revolver.reStartArgs := Seq("im.actor.server.Main"),
          mainClass in Revolver.reStart := Some("im.actor.server.Main"),
          mainClass in Compile := Some("im.actor.server.Main"),
          autoCompilerPlugins := true,
          scalacOptions in(Compile, doc) ++= Seq(
            "-groups",
            "-implicits",
            "-diagrams"
          )
        )
  ).settings(net.virtualvoid.sbt.graph.Plugin.graphSettings: _*)
    .settings(releaseSettings)
    .dependsOn(actorServerSdk)
    .aggregate(
      //      actorDashboard,
      actorServerSdk,
      actorTests
    )
    .settings(
    aggregate in Revolver.reStart := false
  )

  lazy val actorActivation = Project(
    id = "actor-activation",
    base = file("actor-activation"),
    settings = defaultSettings ++
      Seq(
        libraryDependencies ++= Dependencies.activation,
        scalacOptions in Compile := (scalacOptions in Compile).value.filterNot(_ == "-Ywarn-unused-import")
      )
  )
    .dependsOn(actorEmail, actorSms, actorPersist)

  lazy val actorBots = Project(
    id = "actor-bots",
    base = file("actor-bots"),
    settings = defaultSettings ++
      Seq(libraryDependencies ++= Dependencies.bots)
  )
    .dependsOn(actorCore, actorTestkit % "test")

  lazy val actorBotsShared = Project(
    id = "actor-bots-shared",
    base = file("actor-bots-shared"),
    settings = defaultSettings ++ publishSettings ++ Seq(
      version := BotKitVersion,
      libraryDependencies <+= (scalaVersion)("org.scala-lang" % "scala-reflect" % _),
      libraryDependencies ++= Dependencies.botShared,
      addCompilerPlugin("org.scalamacros" % "paradise" % "2.1.0-M5" cross CrossVersion.full)
    )
  )

  lazy val actorBotkit = Project(
    id = "actor-botkit",
    base = file("actor-botkit"),
    settings = defaultSettings ++ publishSettings ++ Revolver.settings ++ Seq(
      version := BotKitVersion,
      libraryDependencies ++= Dependencies.botkit,
      addCompilerPlugin("org.scalamacros" % "paradise" % "2.1.0-M5" cross CrossVersion.full)
    )
  )
    .dependsOn(actorBotsShared)
    .aggregate(actorBotsShared)

  lazy val actorCli = Project(
    id = "actor-cli",
    base = file("actor-cli"),
    settings = defaultSettings ++ Revolver.settings ++ Seq(
      libraryDependencies ++= Dependencies.cli,
      mainClass in Revolver.reStart := Some("im.actor.server.cli.ActorCliApp"),
      mainClass in Compile := Some("im.actor.server.cli.ActorCliApp")
    )
  )
    .dependsOn(actorCore)

  lazy val actorCore = Project(
    id = "actor-core",
    base = file("actor-core"),
    settings = defaultSettings ++ SbtActorApi.settings ++ Seq(
      libraryDependencies ++= Dependencies.core
    )
  )
    .dependsOn(actorCodecs, actorModels, actorPersist, actorRuntime)

  lazy val actorEmail = Project(
    id = "actor-email",
    base = file("actor-email"),
    settings = defaultSettings ++
      Seq(
        libraryDependencies ++= Dependencies.email
      )
  )

  lazy val actorEnrich = Project(
    id = "actor-enrich",
    base = file("actor-enrich"),
    settings = defaultSettings ++ Seq(
      libraryDependencies ++= Dependencies.enrich
    )
  )
    .dependsOn(actorRpcApi, actorRuntime)

  lazy val actorHttpApi = Project(
    id = "actor-http-api",
    base = file("actor-http-api"),
    settings = defaultSettings ++ Seq(
      libraryDependencies ++= Dependencies.httpApi
    )
  )
    .dependsOn(actorBots, actorCore)

  lazy val actorOAuth = Project(
    id = "actor-oauth",
    base = file("actor-oauth"),
    settings = defaultSettings ++
      Seq(
        libraryDependencies ++= Dependencies.oauth
      )
  )
    .dependsOn(actorPersist)

  lazy val actorSession = Project(
    id = "actor-session",
    base = file("actor-session"),
    settings = defaultSettings ++ Seq(
      libraryDependencies ++= Dependencies.session
    )
  )
    .dependsOn(actorPersist, actorCore, actorCodecs, actorCore, actorRpcApi)

  lazy val actorSessionMessages = Project(
    id = "actor-session-messages",
    base = file("actor-session-messages"),
    settings = defaultSettings ++ Seq(libraryDependencies ++= Dependencies.sessionMessages)
  )
    .dependsOn(actorCore)

  lazy val actorRpcApi = Project(
    id = "actor-rpc-api",
    base = file("actor-rpc-api"),
    settings = defaultSettings ++ Seq(
      libraryDependencies ++= Dependencies.rpcApi
    )
  )
    .dependsOn(
    actorActivation,
    actorCore,
    actorOAuth,
    actorSessionMessages,
    actorSms)

  lazy val actorSms = Project(
    id = "actor-sms",
    base = file("actor-sms"),
    settings = defaultSettings ++ Seq(libraryDependencies ++= Dependencies.sms)
  )
    .dependsOn(actorRuntime)

  lazy val actorFrontend = Project(
    id = "actor-frontend",
    base = file("actor-frontend"),
    settings = defaultSettings ++ Seq(
      libraryDependencies ++= Dependencies.frontend
    )
  )
    .dependsOn(actorCore, actorSession)

  lazy val actorCodecs = Project(
    id = "actor-codecs",
    base = file("actor-codecs"),
    settings = defaultSettings ++ Seq(
      libraryDependencies ++= Dependencies.codecs
    )
  )
    .dependsOn(actorModels)

  lazy val actorModels = Project(
    id = "actor-models",
    base = file("actor-models"),
    settings = defaultSettings ++ Seq(
      libraryDependencies ++= Dependencies.models
    )
  )

  lazy val actorPersist = Project(
    id = "actor-persist",
    base = file("actor-persist"),
    settings = defaultSettings ++ Seq(
      libraryDependencies ++= Dependencies.persist
    )
  )
    .dependsOn(actorModels)

  lazy val actorTestkit = Project(
    id = "actor-testkit",
    base = file("actor-testkit"),
    settings = defaultSettings ++ Seq(
      libraryDependencies ++= Dependencies.tests
    )
  ).configs(Configs.all: _*)
    .dependsOn(
      actorCore,
      actorRpcApi,
      actorSession
    )

  lazy val actorRuntime = Project(
    id = "actor-runtime",
    base = file("actor-runtime"),
    settings = defaultSettings ++ Seq(
      libraryDependencies ++= Dependencies.runtime
    )
  )

  lazy val actorServerSdk = Project(
    id = "actor-server-sdk",
    base = file("actor-server-sdk"),
    settings = defaultSettings ++ Seq(
      libraryDependencies ++= Dependencies.sdk
    )
  )
    .dependsOn(
    actorActivation,
    actorBots,
    actorCli,
    actorEnrich,
    actorEmail,
    actorFrontend,
    actorHttpApi,
    actorRpcApi,
    actorOAuth
  ).aggregate(
    actorActivation,
    actorBots,
    actorCli,
    actorCodecs,
    actorCore,
    actorEmail,
    actorEnrich,
    actorFrontend,
    actorHttpApi,
    actorModels,
    actorOAuth,
    actorPersist,
    actorRpcApi,
    actorRuntime,
    actorSession,
    actorSessionMessages,
    actorSms
  )

  lazy val actorTests = Project(
    id = "actor-tests",
    base = file("actor-tests"),
    settings = defaultSettings ++ Testing.settings ++ Seq(
      libraryDependencies ++= Dependencies.tests
    ))
    .configs(Configs.all: _*)
    .dependsOn(
      actorTestkit % "test",
      actorActivation,
      actorCodecs,
      actorCore,
      actorEmail,
      actorEnrich,
      actorFrontend,
      actorHttpApi,
      actorOAuth,
      actorPersist,
      actorRpcApi,
      actorSession
    )
}
