using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TaskBattleBackend.Library.Migrations
{
    /// <inheritdoc />
    public partial class Initial1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "SessionId1",
                table: "Messages",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Messages_SessionId1",
                table: "Messages",
                column: "SessionId1");

            migrationBuilder.AddForeignKey(
                name: "FK_Messages_Sessions_SessionId1",
                table: "Messages",
                column: "SessionId1",
                principalTable: "Sessions",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Messages_Sessions_SessionId1",
                table: "Messages");

            migrationBuilder.DropIndex(
                name: "IX_Messages_SessionId1",
                table: "Messages");

            migrationBuilder.DropColumn(
                name: "SessionId1",
                table: "Messages");
        }
    }
}
