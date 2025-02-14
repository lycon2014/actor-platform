package im.actor.server.persist

import slick.dbio.Effect.{ Read, Write }
import slick.driver.PostgresDriver.api._
import slick.profile.{ FixedSqlStreamingAction, FixedSqlAction }

import im.actor.server.model

final class FilePartTable(tag: Tag) extends Table[model.FilePart](tag, "file_parts") {
  def fileId = column[Long]("file_id", O.PrimaryKey)

  def number = column[Int]("number", O.PrimaryKey)

  def size = column[Int]("size")

  def s3UploadKey = column[String]("s3_upload_key")

  def * = (fileId, number, size, s3UploadKey) <> (model.FilePart.tupled, model.FilePart.unapply)
}

object FilePartRepo {
  val parts = TableQuery[FilePartTable]

  def createOrUpdate(fileId: Long, number: Int, size: Int, s3UploadKey: String): FixedSqlAction[Int, NoStream, Write] =
    parts.insertOrUpdate(model.FilePart(fileId, number, size, s3UploadKey))

  def findByFileId(fileId: Long): FixedSqlStreamingAction[Seq[model.FilePart], model.FilePart, Read] =
    parts.filter(_.fileId === fileId).sortBy(_.number).result
}