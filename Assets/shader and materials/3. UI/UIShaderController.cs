using UnityEngine;
using UnityEngine.UI;

public class UIShaderController : MonoBehaviour
{
    [Header("Metallic Shader")]
    public Material metallicButtonMaterial;
    public Slider speedSlider;
    public Slider angleSlider;
    public Slider sharpnessSlider;

    [Header("Outline Shader")]
    public Material outlineMaterial;
    public Slider colorSpeedSlider;
    public Slider intensitySlider;

    [Header("Mask Shader")]
    public Material maskMaterial;
    public Button changeMaskButton;

    private bool maskEnabled = false;

    void Start()
    {
        // Metallic sliders
        speedSlider.onValueChanged.AddListener((value) => metallicButtonMaterial.SetFloat("_Speed", value));
        angleSlider.onValueChanged.AddListener((value) => metallicButtonMaterial.SetFloat("_Angle", value));
        sharpnessSlider.onValueChanged.AddListener((value) => metallicButtonMaterial.SetFloat("_Sharpness", value));

        // Outline sliders
        colorSpeedSlider.onValueChanged.AddListener((value) => outlineMaterial.SetFloat("_ColorSpeed", value));
        intensitySlider.onValueChanged.AddListener((value) => outlineMaterial.SetFloat("_OutlineIntensity", value));

        // Mask toggle button
        changeMaskButton.onClick.AddListener(ToggleMask);
    }

    void ToggleMask()
    {
        maskEnabled = !maskEnabled;
        float maskValue = maskEnabled ? 1f : 0f;
        maskMaterial.SetFloat("_Mask", maskValue);
    }
}
