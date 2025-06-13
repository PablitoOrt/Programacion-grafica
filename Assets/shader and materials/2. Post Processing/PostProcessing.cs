using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class PostProcessing : MonoBehaviour
{
    [Header("Referencias")]
    [SerializeField] private EffectRenderer effectRenderer;
    [SerializeField] private TMP_Dropdown dropdown;

    [Header("Materials")]
    [SerializeField] private Material grayScaleMaterial;
    [SerializeField] private Material pixelMaterial;
    [SerializeField] private Material vignetteMaterial;
    [SerializeField] private Material filmNoiseMaterial;
    [SerializeField] private Material bloomMaterial;


    [Header("Sliders")]
    [SerializeField] private Slider graySlider;
    [SerializeField] private Slider pixelSlider;
    [SerializeField] private Slider vignettePowerSlider;
    [SerializeField] private Slider vignetteHardnessSlider;
    [SerializeField] private Slider vignetteScaleSlider;
    [SerializeField] private Slider filmNoiseSlider;
    [SerializeField] private Slider bloomIntensitySlider;


    [Header("Panels")]
    [SerializeField] private GameObject grayPanel;
    [SerializeField] private GameObject pixelPanel;
    [SerializeField] private GameObject vignettePanel;
    [SerializeField] private GameObject filmNoisePanel;
    [SerializeField] private GameObject bloomPanel;


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

        if (filmNoiseSlider != null)
            filmNoiseSlider.onValueChanged.AddListener(val => filmNoiseMaterial.SetFloat("_NoiseIntensity", val));

        if (bloomIntensitySlider != null)
            bloomIntensitySlider.onValueChanged.AddListener(val => bloomMaterial.SetFloat("_Bloomintensity", val));
    }

    private void OnEffectChanged(int index)
    {
        grayPanel.SetActive(false);
        pixelPanel.SetActive(false);
        vignettePanel.SetActive(false);
        filmNoisePanel.SetActive(false);
        bloomPanel.SetActive(false);

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
            case 3: // FilmNoise
                effectRenderer.currentEffectMaterial = filmNoiseMaterial;
                filmNoisePanel.SetActive(true);
                break;
            case 4: // Bloom
                effectRenderer.currentEffectMaterial = bloomMaterial;
                bloomPanel.SetActive(true);
                break;
            default:
                effectRenderer.currentEffectMaterial = null;
                break;
        }
    }
}
