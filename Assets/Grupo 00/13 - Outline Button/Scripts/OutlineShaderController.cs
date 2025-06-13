using UnityEngine;
using UnityEngine.UI;

public class OutlineShaderController : MonoBehaviour
{
    [SerializeField] private Material outlineMaterial;
    [SerializeField] private Slider colorSpeedSlider;
    [SerializeField] private Slider intensitySlider;

    private void Start()
    {
        if (outlineMaterial != null)
        {
            colorSpeedSlider?.onValueChanged.AddListener(val => outlineMaterial.SetFloat("_ColorSpeed", val));
            intensitySlider?.onValueChanged.AddListener(val => outlineMaterial.SetFloat("_OutlineIntensity", val));
        }
    }
}
