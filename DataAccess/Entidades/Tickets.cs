using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Entidades
{
    public class Tickets
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int tipocola { get; set; }
        public string estado { get; set; }
        public int  orden { get; set; }
        public int idpersona { get; set; }
        public DateTime fechainicio { get; set; }
        [ForeignKey("idpersona")]
        public Persona Persona { get; set; }
    }
}
