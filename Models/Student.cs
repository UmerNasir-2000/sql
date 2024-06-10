using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace sql;

[Table("students")]
public class Student
{
    [Key]
    public int Id { get; set; }

    public string Email { get; set; } = string.Empty;
}
