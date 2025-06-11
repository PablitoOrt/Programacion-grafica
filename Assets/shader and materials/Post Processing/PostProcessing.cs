using TMPro;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class PostProcessing : MonoBehaviour
{
    [Header("Referencias")]
    [SerializeField] private EffectRenderer effectRenderer;
    [SerializeField] private TMP_Dropdown dropdown;

    [Header("Materials")]
    [SerializeField] private Material grayScaleMaterial;
    [SerializeField] private Material pixelMaterial;
    [SerializeField] private Material vignetteMaterial;

    [Header("Sliders")]
    [SerializeField] private Slider graySlider;
    [SerializeField] private Slider pixelSlider;
    [SerializeField] private Slider vignettePowerSlider; 
    [SerializeField] private Slider vignetteHardnessSlider;
    [SerializeField] private Slider vignetteScaleSlider;

    [Header("Panels")]
    [SerializeField] private GameObject grayPanel;
    [SerializeField] private GameObject pixelPanel;
    [SerializeField] private GameObject vignettePanel;

    private void Start()
    {
        dropdown.onValueChanged.AddListener(OnEffectChanged);
        OnEffectChanged(dropdown.value);

        if (graySlider != null)
            graySlider.onValueChanged.AddListener(val => grayScaleMaterial.SetFloat("_intensity", val));

        if (pixelSlider != null)
            pixelSlider.onValueChanged.AddListener(val => pixelMaterial.SetFloat("_Resolution", val));

        if (vignettePowerSlider != null)
            vignettePowerSlider.onValueChanged.AddListener(val => vignetteMaterial.SetFloat("_MaskPower", val));
        if (vignetteHardnessSlider != null)
            vignetteHardnessSlider.onValueChanged.AddListener(val => vignetteMaterial.SetFloat("_MaskHardness", val));
        if (vignetteScaleSlider != null)
            vignetteScaleSlider.onValueChanged.AddListener(val => vignetteMaterial.SetFloat("_MaskScale", val));
    }

    private void OnEffectChanged(int index)
    {
        grayPanel.SetActive(false);
        pixelPanel.SetActive(false);
        vignettePanel.SetActive(false);

        switch (index)
        {
            case 0: // Grayscale
                effectRenderer.currentEffectMaterial = grayScaleMaterial;
                grayPanel.SetActive(true);
                break;
            case 1: // Pixelation
                effectRenderer.currentEffectMaterial = pixelMaterial;
                pixelPanel.SetActive(true);
                break;
            case 2: // Vignette
                effectRenderer.currentEffectMaterial = vignetteMaterial;
                vignettePanel.SetActive(true);
                break;
            default:
                effectRenderer.currentEffectMaterial = null;
                break;
        }
    }
}
