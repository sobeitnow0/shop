// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2014-2016 elementary LLC. (https://elementary.io)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Authored by: Ian Santopietro <ian@system76.com>
 */

public class AppCenter.Widgets.AppScreenshot : Gtk.DrawingArea {
    private string file_path = null;
    private Gtk.Widget? parent_widget = null;

    construct {
        expand = true;
        halign = Gtk.Align.FILL;
        set_size_request (100, 100);

        draw.connect (draw_callback);
    }

    public void set_path (string path_text) {
        file_path = path_text;
        return;
    }

    public void set_parent (Gtk.Widget? parent) {
        parent_widget = parent;
        return;
    }

    private bool draw_callback (Gtk.Widget? screenshot, Cairo.Context cr) {
        int width = parent_widget.get_allocated_width ();
        int height = parent_widget.get_allocated_height ();
        var scale = get_scale_factor ();
        
        var pixbuf = new Gdk.Pixbuf.from_file_at_scale (
            file_path,
            width,
            height,
            true
        );
        Gdk.cairo_set_source_pixbuf (cr, pixbuf, 0, 0);
        cr.scale (scale, scale);
        cr.paint ();

        return false;
    }

    public virtual Gtk.SizeRequestMode get_size_request () {
        return Gtk.SizeRequestMode.HEIGHT_FOR_WIDTH;
    }

    public virtual void get_preferred_height (out int minimum_height, out int natural_height) {
        minimum_height = 100;
        double val = get_allocated_width () / 1.6;
        natural_height = (int)val;
    }

    public virtual void get_preferred_height_for_width (int width, out int minimum_height, out int natural_height) {
        minimum_height = 100;
        double val = width / 1.6;
        natural_height = (int)val;
    }
}