using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages;

public class MatchesModel : PageModel
{
    private readonly ILogger<MatchesModel> _logger;

    public MatchesModel(ILogger<MatchesModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}
