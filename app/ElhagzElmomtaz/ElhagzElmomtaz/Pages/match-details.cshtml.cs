using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages;

public class MatchDetailsModel : PageModel
{
    private readonly ILogger<MatchDetailsModel> _logger;

    public MatchDetailsModel(ILogger<MatchDetailsModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}
