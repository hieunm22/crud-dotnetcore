using CRUDADO.CustomValidation;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace CRUDADO.Models
{
    public class Billionaire
    {
        public long ID { get; set; }

        [Required]
        public string Name { get; set; }
        
        [Range(1919, 1984)]
        public int? BornYear { get; set; }

        public string Company { get; set; }

        [Required]
        public long NationID { get; set; }
        
        public static long _NationID { get; set; }

        public Nation National { get; set; }

        public double Asset { get; set; }

        public IEnumerable<SelectListItem> Nations = CRUDADO.Controllers.HomeController.NationList.Select(s => new SelectListItem {
            Value = s.ID.ToString(),
            Text =  s.Name,
            Selected = s.ID == _NationID,
        });
    }
}
