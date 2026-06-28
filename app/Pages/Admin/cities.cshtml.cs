using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages.Admin;

public class CitiesModel : PageModel
{
    public List<CityRow> Cities { get; set; } = new();

    public void OnGet()
    {
        Cities = new()
        {
            new(1, "Cairo", "2025-01-01"),
            new(2, "Giza", "2025-01-01"),
            new(3, "Alexandria", "2025-01-05"),
            new(4, "Mansoura", "2025-02-10"),
        };
    }

    public record CityRow(int Id, string Name, string CreatedAt);
}
