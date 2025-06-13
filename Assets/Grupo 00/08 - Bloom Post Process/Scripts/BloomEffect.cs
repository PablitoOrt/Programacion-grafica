using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Camera))]
public class BloomEffect : MonoBehaviour
{
    [SerializeField] private Material bloomMaterial;
    [SerializeField] private Slider intensitySlider;

    private void Start()
    {
        if (intensitySlider != null)
            intensitySlider.onValueChanged.AddListener(val => bloomMaterial.SetFloat("_Bloomintensity", val));
    }

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (bloomMaterial != null)
            Graphics.Blit(src, dest, bloomMaterial);
        else
            Graphics.Blit(src, dest);
    }
}
