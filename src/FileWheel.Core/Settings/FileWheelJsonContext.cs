// System.Text.Json source generation for everything FileWheel persists. Reflection-free and trim-safe.

using System.Text.Json.Serialization;
using FileWheel.Core.History;
using FileWheel.Core.Presets;
using FileWheel.Core.Profiles;

namespace FileWheel.Core.Settings;

[JsonSourceGenerationOptions(
    WriteIndented = true,
    PropertyNamingPolicy = JsonKnownNamingPolicy.CamelCase,
    UseStringEnumConverter = true,
    DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull,
    ReadCommentHandling = System.Text.Json.JsonCommentHandling.Skip,
    AllowTrailingCommas = true)]
[JsonSerializable(typeof(AppSettings))]
[JsonSerializable(typeof(List<Preset>))]
[JsonSerializable(typeof(List<ToolbarProfile>))]
[JsonSerializable(typeof(PresetBundle))]
[JsonSerializable(typeof(List<HistoryEntry>))]
internal sealed partial class FileWheelJsonContext : JsonSerializerContext;

/// <summary>File format used to import / export presets and profiles.</summary>
public sealed class PresetBundle
{
    public int SchemaVersion { get; set; } = 1;
    public List<Preset> Presets { get; set; } = [];
    public List<ToolbarProfile> Profiles { get; set; } = [];
}
