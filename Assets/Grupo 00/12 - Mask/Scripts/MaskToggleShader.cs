using UnityEngine;
using UnityEngine.UI;

public class MaskToggleShader : MonoBehaviour
{
    [SerializeField] private Material maskMaterial;
    [SerializeField] private Button toggleButton;

    private bool maskEnabled = false;

    private void Start()
    {
        if (toggleButton != null && maskMaterial != null)
            toggleButton.onClick.AddListener(ToggleMask);
    }

    private void ToggleMask()
    {
        maskEnabled = !maskEnabled;
        maskMaterial.SetFloat("_Mask", maskEnabled ? 1f : 0f);
    }
}
