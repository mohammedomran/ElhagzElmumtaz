using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages;

public class EditProfileModel : PageModel
{
    private readonly ILogger<EditProfileModel> _logger;

    public EditProfileModel(ILogger<EditProfileModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}
