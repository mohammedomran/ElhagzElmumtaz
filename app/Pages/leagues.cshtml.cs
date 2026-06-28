using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages;

public class LeaguesModel : PageModel
{
    private readonly ILogger<LeaguesModel> _logger;

    public LeaguesModel(ILogger<LeaguesModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}
