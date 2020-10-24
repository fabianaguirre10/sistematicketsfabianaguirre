using DataAccess.Entidades;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.SqlServer.Infrastructure.Internal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public class TicketContext: DbContext
    {
        private readonly string _connectionString;
        protected SqlConnection Connection;
        protected SqlConnection connection => Connection ?? (Connection = GetOpenConnection());

        public TicketContext(DbContextOptions<TicketContext> options)
            : base(options)
        {
            _connectionString = options.FindExtension<SqlServerOptionsExtension>().ConnectionString;
            //extension.ConnectionString = connectionString;
        }

        public SqlConnection GetOpenConnection(bool mars = false)
        {
            var cs = _connectionString;
            if (mars)
            {
                var scsb = new SqlConnectionStringBuilder(cs)
                {
                    MultipleActiveResultSets = true
                };
                cs = scsb.ConnectionString;
            }
            var connection = new SqlConnection(cs);
            connection.Open();
            return connection;
        }

        public SqlConnection GetClosedConnection()
        {
            var conn = new SqlConnection(_connectionString);
            if (conn.State != ConnectionState.Closed) throw new InvalidOperationException("should be closed!");
            return conn;
        }
        /// <summary>
        /// Tabla de Persona
        /// </summary>
        public DbSet<Persona> Persona { get; set; }

        /// <summary>
        /// Tabla de Tickets
        /// </summary>
        public DbSet<Tickets> Tickets { get; set; }

    }
}
