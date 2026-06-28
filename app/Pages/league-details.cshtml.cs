using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages;

public class LeagueDetailsModel : PageModel
{
    private readonly ILogger<LeagueDetailsModel> _logger;

    public LeagueDetailsModel(ILogger<LeagueDetailsModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}
