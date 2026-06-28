using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages.Admin;

public class MatchCreateModel : PageModel
{
    public List<string> Stadiums { get; set; } = new();

    public void OnGet()
    {
        Stadiums = new() { "Fifth Settlement Arena", "Giza Sports Hub", "Alex Beach Pitch" };
    }
}
