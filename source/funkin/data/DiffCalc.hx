package funkin.data;

// Replace this with a better version of Etterna's MSD shit
// Only having this now because I'm too lazy.

import flixel.util.FlxSort;
import funkin.states.PlayState;
import flixel.math.FlxMath;
import funkin.data.Song.SwagSong;

class SmallNote // basically Note.hx but small as fuck
{
	public var strumTime:Float;
	public var noteData:Int;

	public function new(strum, data)
	{
		strumTime = strum;
		noteData = data;
	}
}

class DiffCalc
{
	public static var scale = 3 * 1.8;

	public static var lastDiffHandOne:Array<Float> = [];
	public static var lastDiffHandTwo:Array<Float> = [];


	public static function sortByNotes(Obj1:SmallNote, Obj2:SmallNote):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	public static function sortByLength(Obj1, Obj2):Int
	{
		return FlxSort.byValues(FlxSort.DESCENDING, Obj1.length, Obj2.length);
	}

	public static function CalculateDiff(song:SwagSong, ?accuracy:Float = .98)
	{
		// cleaned notes
		var cleanedNotes:Array<SmallNote> = [];

		if (song.notes == null)
			return 0.0;

		if (song.notes.length == 0)
			return 0.0;

		// find all of the notes
		for (i in song.notes) // sections
		{
			for (ii in i.sectionNotes) // notes
			{
				var gottaHitNote:Bool = i.mustHitSection ? (ii[0] < song.keyCount) : (ii[0] >= song.keyCount);

				if (gottaHitNote)
					cleanedNotes.push(new SmallNote(ii[0], Math.floor(Math.abs(ii[1]))));
			}
		}

		cleanedNotes.sort(sortByNotes);

		var reqEffort:Float = 0;
		if (cleanedNotes.length != 0) {
			var maxNPS = 1;
			var length = Math.ceil(cleanedNotes[cleanedNotes.length-1].strumTime / 1000 / 2);
			var noteClusters:Array<Array<SmallNote>> = [];
			var meanNPS = (cleanedNotes.length) / ((cleanedNotes[cleanedNotes.length-1].strumTime - cleanedNotes[0].strumTime) * 0.001);
			for (cluster in 0...length) {
				for (offset in [0,1]) {
					var clust:Array<SmallNote> = [];
					var time = (cluster * 2 + offset) * 1000;
					var endTime = time + 2000; 
					for (note in cleanedNotes) {
						if (note.strumTime >= time && note.strumTime <= endTime) {
							clust.push(note);
						}
					}
					noteClusters.push(clust);
				}
			}
			noteClusters.sort(sortByLength);
			maxNPS = noteClusters.length != 0 ? noteClusters[0].length : 1;
			reqEffort = meanNPS * FlxMath.bound(maxNPS / 5, 1, Math.POSITIVE_INFINITY);
		}

		return FlxMath.roundDecimal(reqEffort * accuracy, 2);
	}
}