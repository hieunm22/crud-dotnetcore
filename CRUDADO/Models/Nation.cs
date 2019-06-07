using CRUDADO.CustomValidation;
using System.ComponentModel.DataAnnotations;

namespace CRUDADO.Models
{
    public class Nation
    {
        public long ID { get; set; }

        [Required]
        public string Name { get; set; }

        public double Area { get; set; }
    }
}
