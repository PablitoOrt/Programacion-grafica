using UnityEngine;
using UnityEngine.UI;

//[RequireComponent(typeof(Camera))]
public class VignettePostProcessing : MonoBehaviour
{
    [Header("Material con Shader de Vignette")]
    [SerializeField] private Material vignetteMaterial;

    [Header("UI para controlar parámetros")]
    [SerializeField] private Slider PowerSlider;
    [SerializeField] private Slider HardnessSlider;
    [SerializeField] private Slider ScaleSlider;

    private void Start()
    {
        if (PowerSlider != null)
            PowerSlider.onValueChanged.AddListener(UpdatePower);

        if (HardnessSlider != null)
            HardnessSlider.onValueChanged.AddListener(UpdateHardness);

        if (ScaleSlider != null)
            ScaleSlider.onValueChanged.AddListener(UpdateScale);
    }

    private void Update()
    {
      
    }

    private void UpdatePower(float value)
    {
        vignetteMaterial.SetFloat("_MaskPower", value);
    }

    private void UpdateHardness(float value)
    {
        vignetteMaterial.SetFloat("_MaskHardness", value);
    }

    private void UpdateScale(float value)
    {
        vignetteMaterial.SetFloat("_MaskScale", value);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (vignetteMaterial != null)
        {
            Graphics.Blit(source, destination, vignetteMaterial);
        }
        else
        {
            Graphics.Blit(source, destination);
        }
    }
}
