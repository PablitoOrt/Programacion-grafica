using TMPro;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class PostProcessing : MonoBehaviour
{
    [Header("Referencias")]
    [SerializeField] private EffectRenderer effectRenderer; // arrastra la cámara con el script
    [SerializeField] private TMP_Dropdown dropdown;

    [Header("Materials")]
    [SerializeField] private Material grayScaleMaterial;
    [SerializeField] private Material pixelMaterial;

    [Header("Sliders")]
    [SerializeField] private Slider graySlider;
    [SerializeField] private Slider pixelSlider;

    [Header("Panels")]
    [SerializeField] private GameObject grayPanel;
    [SerializeField] private GameObject pixelPanel;
    [SerializeField] private GameObject vignettePanel;

    private void Start()
    {
        dropdown.onValueChanged.AddListener(OnEffectChanged);
        OnEffectChanged(dropdown.value); // aplicar el actual al iniciar

        if (graySlider != null)
            graySlider.onValueChanged.AddListener(val => grayScaleMaterial.SetFloat("_intensity", val));

        if (pixelSlider != null)
            pixelSlider.onValueChanged.AddListener(val => pixelMaterial.SetFloat("_Resolution", val));
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
                effectRenderer.currentEffectMaterial = null;
                vignettePanel.SetActive(true);
                break;
            default:
                effectRenderer.currentEffectMaterial = null;
                break;
        }
    }
}
