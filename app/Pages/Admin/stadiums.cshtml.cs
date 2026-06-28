using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages.Admin;

public class StadiumsModel : PageModel
{
    public List<StadiumRow> Stadiums { get; set; } = new();
    public List<string> Cities { get; set; } = new();

    public void OnGet()
    {
        Cities = new() { "Cairo", "Giza", "Alexandria", "Mansoura" };
        Stadiums = new()
        {
            new(1, "Fifth Settlement Arena", "Cairo", "90th Street, Fifth Settlement", "https://maps.google.com/?q=30.0,31.4"),
            new(2, "Giza Sports Hub", "Giza", "Faisal St, Giza", "https://maps.google.com/?q=30.0,31.2"),
            new(3, "Alex Beach Pitch", "Alexandria", "Corniche Rd, Alexandria", "https://maps.google.com/?q=31.2,29.9"),
        };
    }

    public record StadiumRow(int Id, string Name, string City, string Address, string MapsUrl);
}
